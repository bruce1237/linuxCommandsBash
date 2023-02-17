#!/bin/bash
# background-llp.sh
for i in 1 2 3 4 5  6 7 8 9 10   # first loop
do 
    echo -n "$i "
    sleep 0.5
done & # run this loop in background will sometimes execute after second loop.

# sleep 1

# wait

echo # this 'echo' somtime will not display.

for i in 11 12 13 14 15 16 17 18 19 20  # second loop
do 
    echo -n "$i"
done

echo # this 'echo' sometime will not display

# sleep 1
# wait
