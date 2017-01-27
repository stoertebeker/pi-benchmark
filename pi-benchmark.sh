#!/bin/bash

#small CPU Benchmark which calculates pi and gives back the time

#params
ROUNDS=10
LENGTH=4000

#script
for (( c=1; c<=$ROUNDS; c++ ))
do
  (time echo "scale=4000; a(1)*4" | bc -l >  /dev/zero) 2>> tmp.txt
  echo "Run $c of $ROUNDS finished"
done

#filter time output
grep real tmp.txt | sed s/real//g | sed s/0m//g | sed s/s//g | sed 's/^[ \t]*//' >tmp2.txt

#read filtered output
l=0
while read float; do
  [ $l = 0 ] && op="$float" || op="${op}+$float"
  ((l++))
done <tmp2.txt

#calculate
result=$(bc <<< "scale=2;(${op})/$l")

echo "Calculated Pi with $LENGTH digits in $result seconds"

#cleanup
rm tmp.txt
rm tmp2.txt

exit 0

