#!/bin/bash

if test "$USER" != "bo" 
then
    {
        # clear #clear screen
        echo "Test you are not bo"
    }
else
    {
        echo "Test YOU ARE bo"
    }
fi

# test is synonym of [], make sure the space and ;
# [ expression ];
#  ^          ^ ^
# test is used for test expression

if [ "$USER" != "bo" ];
then
    {
        # clear #clear screen
        echo "you are not bo"
    }
else
    {
        echo "YOU ARE bo"
    }
fi



num=300

if test $num -gt 300
then
{
    echo "over"
}
else
{
    echo "under"
}
fi


# Common Uses of test

# 	1.	String Comparisons:
# 	•	test "$str1" = "$str2" or [ "$str1" = "$str2" ]: True if the strings are equal.
# 	•	test "$str1" != "$str2" or [ "$str1" != "$str2" ]: True if the strings are not equal.
# 	•	test -z "$str" or [ -z "$str" ]: True if the string is empty.
# 	•	test -n "$str" or [ -n "$str" ]: True if the string is not empty.
# 	2.	Numerical Comparisons:
# 	•	test "$num1" -eq "$num2" or [ "$num1" -eq "$num2" ]: True if the numbers are equal.
# 	•	test "$num1" -ne "$num2" or [ "$num1" -ne "$num2" ]: True if the numbers are not equal.
# 	•	test "$num1" -gt "$num2" or [ "$num1" -gt "$num2" ]: True if the first number is greater than the second.
# 	•	test "$num1" -lt "$num2" or [ "$num1" -lt "$num2" ]: True if the first number is less than the second.
# 	3.	File Tests:
# 	•	test -e "$file" or [ -e "$file" ]: True if the file exists.
# 	•	test -f "$file" or [ -f "$file" ]: True if the file exists and is a regular file.
# 	•	test -d "$file" or [ -d "$file" ]: True if the file exists and is a directory.

if [ -d /codes ];
then
{
    echo "exist"
}
else 
{
    echo "NOT exist"
}
fi