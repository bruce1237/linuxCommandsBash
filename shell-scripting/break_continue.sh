#!/bin/bash

while true
do
    echo "to end type y"
    read a
    if test $a = "y"
    then
    {
        break
    }
    fi
    if test $a = "x"
    then
    {
        continue
    }
    fi

    echo "LLLLL"

done