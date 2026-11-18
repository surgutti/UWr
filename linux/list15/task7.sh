#!/usr/bin/env bash

size=512
max_size=$((1024 * 1024 * 1024))

ll=0
rr=$max_size

while [[ $ll -le $rr ]]; do
  mm=$((($ll+$rr)/2))
  echo "mm: $ll $mm $rr"
  
  size=$mm


  rm -f "test.img"
  truncate -s "$size" "test.img"
  if mke2fs -q -t ext2 -F -m 0 "test.img" >/dev/null 2>&1; then
    rr=$mm
    echo "ok: $size"
    #exit 0
  else
    ll=$(($mm+1))
    echo "bad: $size"
  fi
done

echo "$ll $rr"

exit 0
while [ "$size" -le "$max_size" ]; do
    rm -f "test.img"
    truncate -s "$size" "test.img"

    if mke2fs -q -t ext2 -F -m 0 "test.img" >/dev/null 2>&1; then
      echo "ok: $size"
      exit 0
    fi
    echo "fail: $size"

    size=$((size * 2))
done
