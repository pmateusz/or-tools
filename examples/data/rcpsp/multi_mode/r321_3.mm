************************************************************************
file with basedata            : cr321_.bas
initial value random generator: 2024705964
************************************************************************
projects                      :  1
jobs (incl. supersource/sink ):  18
horizon                       :  131
RESOURCES
  - renewable                 :  3   R
  - nonrenewable              :  2   N
  - doubly constrained        :  0   D
************************************************************************
PROJECT INFORMATION:
pronr.  #jobs rel.date duedate tardcost  MPM-Time
    1     16      0       22        4       22
************************************************************************
PRECEDENCE RELATIONS:
jobnr.    #modes  #successors   successors
   1        1          3           2   3   4
   2        3          2          11  15
   3        3          3           5   7  11
   4        3          3           7  11  14
   5        3          3           6   9  12
   6        3          3           8  10  16
   7        3          2           8  15
   8        3          1          17
   9        3          2          15  16
  10        3          2          13  14
  11        3          2          13  16
  12        3          2          13  14
  13        3          1          17
  14        3          1          17
  15        3          1          18
  16        3          1          18
  17        3          1          18
  18        1          0        
************************************************************************
REQUESTS/DURATIONS:
jobnr. mode duration  R 1  R 2  R 3  N 1  N 2
------------------------------------------------------------------------
  1      1     0       0    0    0    0    0
  2      1     3       6    9    2    4    0
         2    10       5    5    2    0    8
         3    10       6    5    2    4    0
  3      1     2       4    4    9    0    7
         2     4       1    4    5    0    6
         3     4       3    4    4    0    6
  4      1     6       8    9    6    4    0
         2     6       8   10    6    3    0
         3     7       7    5    4    2    0
  5      1     4       9    8    4    8    0
         2     7       6    4    3    0    9
         3    10       4    2    1    0    8
  6      1     6       9    7    6    6    0
         2     8       9    7    5    4    0
         3    10       7    6    4    3    0
  7      1     5       4    5    8    6    0
         2     9       3    3    5    5    0
         3    10       3    3    1    5    0
  8      1     6       9    8    9    0    8
         2     8       9    4    6    8    0
         3    10       9    4    4    7    0
  9      1     2       9    7    2    4    0
         2     3       6    7    2    2    0
         3     5       2    6    2    0   10
 10      1     1       5    6    7    7    0
         2     5       5    6    6    0    8
         3     5       4    6    7    7    0
 11      1     2       4   10    3    5    0
         2     8       4   10    2    0    8
         3    10       3   10    2    4    0
 12      1     2      10    3    3    4    0
         2     7       9    3    3    3    0
         3     8       8    3    3    0    2
 13      1     2       8    9    6    0    5
         2     8       5    8    6    0    3
         3    10       4    7    5    2    0
 14      1     1       8    7    4    5    0
         2     8       8    6    2    0    7
         3    10       5    6    2    4    0
 15      1     2      10    9    8    0    5
         2     5       9    8    5    0    4
         3    10       9    8    3    9    0
 16      1     2       7    7    8    0    6
         2     6       6    5    8    9    0
         3     7       6    4    7    7    0
 17      1     4       9    6    9    5    0
         2     4       7    7    9    6    0
         3     5       7    4    8    5    0
 18      1     0       0    0    0    0    0
************************************************************************
RESOURCEAVAILABILITIES:
  R 1  R 2  R 3  N 1  N 2
   16   16   14   69   64
************************************************************************
