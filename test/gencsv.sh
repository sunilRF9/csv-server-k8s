#!/bin/bash
END=$1
if [ $# -eq 0 ]
  then
    echo "No arguments supplied, setting default as 10"
    END=10
fi
cat /dev/null > inputFile
for ((i=1;i<=END;i++)); do
    echo $i,$RANDOM >> inputFile
done
