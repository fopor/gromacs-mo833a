PATH_TO_BUILD='../../build/bin'

perf record -a -g -o perf_sthread.data $PATH_TO_BUILD/gmx mdrun -v -deffnm em
perf record -a -g -o perf_mthread.data $PATH_TO_BUILD/gmx mdrun -v -deffnm em
valgrind --tool=callgrind $PATH_TO_BUILD/gmx mdrun -v -deffnm em
valgrind --tool=callgrind $PATH_TO_BUILD/gmx mdrun -v -deffnm em
