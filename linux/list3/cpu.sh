#!/usr/bin/bash

read_cpu() {
  read cpu user nice system idle iowait irq softirq steal rest < /proc/stat
  user=$((user + nice))
  system=$((system + irq + softirq + steal))
  total=$((user + system + idle + iowait))
  echo "$user $system $idle $iowait $total"
}

read u1 s1 i1 w1 t1 < <(read_cpu)

while ! read -r -s -t 0.2 -n 1 key; 
do
  read u2 s2 i2 w2 t2 < <(read_cpu)

  du=$((u2 - u1))
  ds=$((s2 - s1))
  di=$((i2 - i1))
  dw=$((w2 - w1))
  dt=$((t2 - t1))

  awk -v du="$du" -v ds="$ds" -v di="$di" -v dw="$dw" -v dt="$dt" '
    BEGIN {
      printf "\ruser: %.1f%%  system: %.1f%%  idle: %.1f%%  iowait: %.1f%% ",
             100*du/dt, 100*ds/dt, 100*di/dt, 100*dw/dt
    }'

  u1=$u2
  s1=$s2
  i1=$i2
  w1=$w2
  t1=$t2
done

echo ""
