#!/bin/bash

echo "type a city to find costa"
echo
read -p "city: " city

case $city in 
    "chelmsford") location="CM";;
    "london") location="LN";;
    "cityA" | "cityB") location="AB";;
    *)location="Anything";;
esac

echo $location



echo "type a city to find costa"
echo
read -p "city: " city

case $city in 
    "chelmsford") 
        location="CM";;
    "london") 
        location="LN";;
    "cityA" | "cityB") 
        location="AB";;
    *)
        location="Anything";;
esac

echo $location