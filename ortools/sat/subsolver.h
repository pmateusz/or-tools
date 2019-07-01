// Copyright 2010-2018 Google LLC
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

// Simple framework for choosing and distributing a solver "sub-tasks" on a set
// of threads.

#ifndef OR_TOOLS_SAT_SUBSOLVER_H_
#define OR_TOOLS_SAT_SUBSOLVER_H_

#include <cmath>
#include <cstdint>
#include <functional>
#include <string>
#include <vector>

#include "ortools/base/integral_types.h"

#if !defined(__PORTABLE_PLATFORM__)
#include "ortools/base/threadpool.h"
#endif  // __PORTABLE_PLATFORM__

namespace operations_research {
namespace sat {

// The API used for distributing work. Each subsolver can generate tasks and
// synchronize itself with the rest of the world.
//
// Note that currently only the main thread interact with subsolvers. Only the
// tasks generated by GenerateTask() are executed in parallel in a threadpool.
class SubSolver {
 public:
  SubSolver(int id, const std::string& name) : id_(id), name_(name) {}
  virtual ~SubSolver() {}

  // Returns true iff GenerateTask() can be called.
  //
  // Note(user): In the current design, a SubSolver is never deleted until the
  // end of the Solve() that created it. But is is okay to always return false
  // here and release the memory used by the Subsolver internal if there is no
  // need to call this Subsolver ever again. The overhead of iterating over it
  // in the main solver loop should be minimal.
  virtual bool TaskIsAvailable() = 0;

  // Returns a task to run. The task_id is just an ever increasing counter that
  // correspond to the number of total calls to GenerateTask().
  //
  // TODO(user): We could use a more complex selection logic and pass in the
  // deterministic time limit this subtask should run for. Unclear at this
  // stage.
  virtual std::function<void()> GenerateTask(int64 task_id) = 0;

  // Synchronizes with the external world from this SubSolver point of view.
  // Also incorporate the results of the latest completed tasks if any.
  //
  // Note(user): The intended implementation for determinism is that tasks
  // update asynchronously (and so non-deterministically) global "shared"
  // classes, but this global state is incorporated by the Subsolver only when
  // Synchronize() is called.
  virtual void Synchronize() = 0;

  // Returns the score as updated by the completed tasks before the last
  // Synchronize() call. Everything else being equal, we prefer to run a
  // SubSolver with the highest score.
  //
  // TODO(user): This is unused for now.
  double Score() const { return score_; }

  // Returns the total deterministic time spend by the completed tasks before
  // the last Synchronize() call.
  //
  // TODO(user): This is unused for now.
  double DeterminisitcTime() const { return deterministic_time_; }

  // Returns the name of this SubSolver. Used in logs.
  std::string name() const { return name_; }

 protected:
  const int id_;
  const std::string name_;
  double score_ = 0.0;
  double deterministic_time_ = 0.0;
};

// Executes the following loop:
// 1/ Synchronize all in given order.
// 2/ generate and schedule one task from the current "best" subsolver.
// 3/ repeat until no extra task can be generated and all tasks are done.
//
// The complexity of each selection is in O(num_subsolvers), but that should
// be okay given that we don't expect more than 100 such subsolvers.
//
// Note that it is okay to incorporate "special" subsolver that never produce
// any tasks. This can be used to synchronize classes used by many subsolvers
// just once for instance.
void NonDeterministicLoop(
    const std::vector<std::unique_ptr<SubSolver>>& subsolvers, int num_threads);

// Similar to NonDeterministicLoop() except this should result in a
// deterministic solver provided that all SubSolver respect the Synchronize()
// contract.
//
// Executes the following loop:
// 1/ Synchronize all in given order.
// 2/ generate and schedule up to batch_size tasks using an heuristic to select
//    which one to run.
// 3/ wait for all task to finish.
// 4/ repeat until no task can be generated in step 2.
void DeterministicLoop(
    const std::vector<std::unique_ptr<SubSolver>>& subsolvers, int num_threads,
    int batch_size);

// Same as above, but specialized implementation for the case num_threads=1.
// This avoids using a Threadpool altogether. It should have the same behavior
// than the functions above with num_threads=1 and batch_size=1. Note that an
// higher batch size will not behave in the same way, even if num_threads=1.
void SequentialLoop(const std::vector<std::unique_ptr<SubSolver>>& subsolvers);

// Basic adaptive [0.0, 1.0] parameter that can be increased or decreased with a
// step that get smaller and smaller with the number of updates.
//
// Note(user): The current logic work well in practice, but has no theoretical
// foundation. So it might be possible to use better formulas depending on the
// situation.
//
// TODO(user): In multithread, we get Increase()/Decrease() signal from
// different thread potentially working on different difficulty. The class need
// to be updated to properly handle this case. Increase()/Decrease() should take
// in the difficulty at which the signal was computed, and the update formula
// should be changed accordingly.
class AdaptiveParameterValue {
 public:
  // Initial value is in [0.0, 1.0], both 0.0 and 1.0 are valid.
  explicit AdaptiveParameterValue(double initial_value)
      : value_(initial_value) {}

  void Reset() { num_changes_ = 0; }

  void Increase() {
    const double factor = IncreaseNumChangesAndGetFactor();
    value_ = std::min(1.0 - (1.0 - value_) / factor, value_ * factor);
  }

  void Decrease() {
    const double factor = IncreaseNumChangesAndGetFactor();
    value_ = std::max(value_ / factor, 1.0 - (1.0 - value_) * factor);
  }

  double value() const { return value_; }

 private:
  // We want to change the parameters more and more slowly.
  double IncreaseNumChangesAndGetFactor() {
    ++num_changes_;
    return 1.0 + 1.0 / std::sqrt(num_changes_ + 1);
  }

  double value_;
  int64_t num_changes_ = 0;
};

}  // namespace sat
}  // namespace operations_research

#endif  // OR_TOOLS_SAT_SUBSOLVER_H_
