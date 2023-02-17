#!/bin/bash
# ex9.sh
# variables: assignment and substitution
a=375
hello=$a
#   ^ ^ 

# -------------------------------------------------------------------------
# no space permitted on either side of = sign when initializing variables
# what happens if there is a space?
# 
# "variable =value"
#          ^
# script tries to run "variable" command with one argument, "=value",
# 
# "variable"= value"
#            ^
# script tries to run "value" command with the
# environment variable "variable" set to "".
# -----------------------------------------------------------------------


echo hello # hello
# not a variable reference, just the string "hello" ...

echo $hello  # 375
#    ^  this is a variable reference

echo ${hello} # 375
#       likewise, a variable reference, as above.

# Quoting . . .
echo "$hello"  # 375
echo "${hello}"  # 375

echo 

hello="A B C   D"
echo $hello  # A B C D
echo "$hello" # A B C   D 
# as we see, echo $hello and echo "$hello" give different results
# ==============================================
# Quoting a variable preserves whitespace.
# ==============================================

echo

echo '$hello'  # $hello
# variable referencing disabled/escaped by single quotes,
# which causes the `$` to be interpreted literally.

# notice the effect of different types of quoting.


hell=   # set it to a null value
echo "\$hello (null value) == $hello"   # $hello (null value) = 
# note that setting a variable to a null value is not the same as unsetting it.
# although the end result is the same, see below
# 
# --------------------------------------------------------------------------------
# 

echo; echo
numbers="one tow three"
#           ^   ^
other_numbers="1 2 3"
#               ^ ^
# if there is whitespace embedded within a variable,
# then quotes are necessary
# other_numbers=1 2 3   # gives an error message

echo "number_numbers = $numbers"  
echo "other_numbers = $other_numbers"  #other_numbers = 1 2 3
# escaping the whitespace also works
mixed_bag=2\ ---\ whatever
#           ^    ^  space after escape (\)
echo "$mixed_bag"    # 2 --- whatever

echo; echo

echo "uninitialized_variable = $uninitialized_variable"
# uninitialized variable has null value (no value at all)
uninitialized_variable=     # Declaring, but not initializing it
#                             same as setting it to a null value as above
echo "uninitialized_variable = $uninitialized_variable"
# it still has a null value.

uninitialized_variable=23   # set
unset uninitialized_variable    # unset
echo "uninitialized_variable = $uninitialized_variable"
# uninitialized_variable = 
# it still h as a null value
echo
exit 9
