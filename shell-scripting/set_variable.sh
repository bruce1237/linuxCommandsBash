#!/bin/bash
variable="one two three four five"

set -- $variable
#  set positional parameters to the contests of "$variable"

first_param=$1
second_param=$2
shift; shift   # shift past first two positional params, `shift 2` also works
remaining_params="$*"

echo 
echo "first parameter = $first_param"  # one
echo "second parameter = $second_param" # two
echo "remaining paramters = $remaining_params" # three four five

echo; echo

# again
set -- $variable
first_param=$1
second_param=$2
echo "first parameter = $first_param" # one
echo "second parameter = $second_param" # tow

# ===================================================
set --
#  unsets positional parameters if no variable specified
first_param=$1
second_param=$2
echo "first parameter = $first_param"
echo "second parameter = $second_param"

exit 0
