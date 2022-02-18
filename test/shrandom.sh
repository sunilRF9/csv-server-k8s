#!/bin/bash
a=1
while [ $a -lt 11 ]
do
   echo $a, $RANDOM
   a=`expr $a + 1`
done
