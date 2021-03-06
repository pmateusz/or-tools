************************************************************************
file with basedata            : cr458_.bas
initial value random generator: 19054
************************************************************************
projects                      :  1
jobs (incl. supersource/sink ):  18
horizon                       :  135
RESOURCES
  - renewable                 :  4   R
  - nonrenewable              :  2   N
  - doubly constrained        :  0   D
************************************************************************
PROJECT INFORMATION:
pronr.  #jobs rel.date duedate tardcost  MPM-Time
    1     16      0       23        4       23
************************************************************************
PRECEDENCE RELATIONS:
jobnr.    #modes  #successors   successors
   1        1          3           2   3   4
   2        3          3           6   9  10
   3        3          2           5  13
   4        3          2          10  13
   5        3          3           6   8   9
   6        3          3           7  11  14
   7        3          2          12  15
   8        3          1          10
   9        3          2          16  17
  10        3          3          11  14  15
  11        3          1          12
  12        3          2          16  17
  13        3          2          14  16
  14        3          1          17
  15        3          1          18
  16        3          1          18
  17        3          1          18
  18        1          0        
************************************************************************
REQUESTS/DURATIONS:
jobnr. mode duration  R 1  R 2  R 3  R 4  N 1  N 2
------------------------------------------------------------------------
  1      1     0       0    0    0    0    0    0
  2      1     1      10    0    0    0    9    4
         2     4       9    5    0    0    4    3
         3     7       9    0    3    9    3    3
  3      1     3       6    8    0    0   10    7
         2     8       5    7    5    0   10    4
         3    10       4    4    0    6    9    2
  4      1     1       4    8    8    0   10    8
         2     7       0    5    0    4    9    8
         3    10       0    0    6    3    8    8
  5      1     7       0    5    0    7    9    7
         2     8       0    4    0    7    8    4
         3     8       0    5    0    0    7    3
  6      1     2       0    0    6    0    5   10
         2     6       0    5    0    5    4    7
         3     9       0    4    0    0    2    7
  7      1     5       5    8    4    0    3    5
         2     5       0    0    0    4    3    6
         3     8       0    8    0    0    3    5
  8      1     4      10    0    5    0    7    3
         2     8       9    0    0    7    4    3
         3    10       9    2    0    0    3    3
  9      1     2       7    8   10    0    8   10
         2     3       0    0    0    8    5    8
         3     7       4    6    0    6    3    7
 10      1     1       7    7    0    8    2    8
         2     2       0    0    0    7    2    7
         3     6       2    0    0    7    1    5
 11      1     1       0    0    6    0    8    1
         2     5       2    0    0    7    7    1
         3    10       0    7    2    6    2    1
 12      1     3       7    0    6    0    5    7
         2     3       7    7    0    0    5    7
         3     4       0    7    8    0    1    6
 13      1     1       0    0    8    0    5    6
         2     6       0    8    0    0    4    4
         3     8       3    5    0    0    4    3
 14      1     2       0    0    0    3   10    3
         2     7       7    5    6    0    9    3
         3    10       0    5    0    3    8    2
 15      1     2       6    0    7    8    2    8
         2     3       4    4    5    7    2    7
         3    10       3    0    0    4    2    6
 16      1     3       0   10    0    0    8    6
         2     5       7    7    5    8    8    6
         3     9       0    0    0    3    8    5
 17      1     3       0    0    3    0    7   10
         2     8       4    0    3    0    4    9
         3     9       0   10    0    7    2    8
 18      1     0       0    0    0    0    0    0
************************************************************************
RESOURCEAVAILABILITIES:
  R 1  R 2  R 3  R 4  N 1  N 2
   15   13   11   14  108  104
************************************************************************
