#!/usr/bin/bash

filter() {
  local p n
  if ! read p; then
    return 0
  fi

  echo $p

  while read n; do
    (( n % p != 0 )) && echo "$n" 
  done | filter &

  wait
}

MAX=$1
(( 2 <= MAX && MAX <= 10000 )) || exit 0
seq 2 $MAX | filter 
