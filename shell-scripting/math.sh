# using bc to handle it

read -p "numberA: " A
read -p "numberB: " B

multiply=`echo "$A * $B" | bc`

echo "Multiply " $multiply