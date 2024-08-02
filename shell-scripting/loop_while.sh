#!/bin/bash

choice="0"
while(($choice != "1"))
do
    echo "please select option"
    echo
    echo "1 - exit"
    read choice
done


while read lineFromFile
do
    echo "----" $lineFromFile
done < ./test_exclamation_mark.sh


fileToRead=./test_exclamation_mark.sh

while read line
do
    echo "+++++" $line
done < $fileToRead