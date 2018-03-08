#!/bin/sh
#sudo gcc -std=c99 proc_monitor.c -o proc_monitor -g -lpthread $(pkg-config --cflags --libs libnl-3.0 libnl-genl-3.0)
#sudo chmod u+s proc_monitor
#gcc -o incr_work -O3 incr_work.c
##gcc -o incr_work.sort -O3 spe_new_exp_sort.c
gcc -o incr_work.matc -O3 new_exp_matc.c
gcc -o incr_work.matr -O3 new_exp_matr.c
mv incr_work.matc incr_work.matr ..
