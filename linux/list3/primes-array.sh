#!/usr/bin/bash

MAX=$1

declare -a PRIMES
PRIMES[0]=2

i=1
for ((n=3; n <= MAX; n++)); do
  j=0
  while (( PRIMES[j] * PRIMES[j] <= n )); do
    if (( n % PRIMES[j] == 0 )); then
      continue 2
    fi
    (( j++ ))
  done
  PRIMES[i]=$n
  (( i++ ))
done

echo "${PRIMES[*]}" | tr ' ' '\n'
