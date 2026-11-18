#/usr/bin/env bash

lscgroup
cgcreate -g memory:kurs_linux
lscgroup

cgget -r memory.max kurs_linux
cgset -r memory.max=2097152 kurs_linux # max 2MiB
cgget -r memory.max kurs_linux

cgget -r memory.swap.max kurs_linux
cgset -r memory.swap.max=0 kurs_linux
cgget -r memory.swap.max kurs_linux

cgexec -g memory:kurs_linux ./greedy 1048576 # success
cgexec -g memory:kurs_linux ./greedy 3145728 # killed

cgdelete -g memory:kurs_linux
lscgroup
