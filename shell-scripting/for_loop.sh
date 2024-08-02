#!/bin/bash

clear
totalSize=0
currentFileSize=0

for currentFile in ./*.sh
do 
    echo $currentFile
    currentSize=`ls -l $currentFile | tr -s " " | cut -f5 -d " "`
    let totalSize=totalSize+currentSize
    let totalSize=$totalSize+$currentSize
    echo "Current size " $currentSize
done

echo "Total Size" $totalSize





# for through array
cities=(london chelmsford "new york")

for ((i=0; i<${#cities}; i++));
do
    echo ${cities[$i]}
done

for city in $cities
do
    echo $city

done