#!/bin/bash
departs=(IT "Human Resource" Sales B C D E A 5 4 3 2 1)

echo "print all elements of array"
echo ${departs[*]}


total=0
for x in ${departs[*]}
do
    echo $x
    let total=total+x
done


echo "total is" $total

echo "skip first 2 then return next 3 elements"
echo ${departs[*]:2:3}

echo "replace Sales into Marketing"
newArray=${departs[*]/Sales/Marketing}
echo ${newArray[*]}

echo '${cities[@]} 在引用时保留了数组元素的独立性，而 ${cities[*]} 则将所有元素连接成一个字符串。'
echo "size of array is " ${#departs[*]}
echo "size of array is " ${#departs[@]}
echo "size of array is " ${departs[*]}
echo "size of array is " ${departs[@]}



echo
echo "sort Array"
echo

sortedArray=`sort <<<"${departs[@]}"`
echo ${sortedArray[*]}

sorted=($(printf "%s\n" "${departs[@]}" | sort))
echo "${sorted[@]}"