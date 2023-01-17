# shell script

>To enable execute the `.sh` file, 
>
>`chmod +x abc.sh`
>
>to run the sh: `./abc.sh`


# variable

```shell
#! /bin/bash

# this is a command
echo hello world

# VARIABLES
# uppercase by convention
# allows letters, numbers, underscores
NAME="ABC"  #define a variable
echo "my name is $NAME" # using variable style 1
echo "my name is ${NAME}" # using variable style 2
```

# user input

```shell
read -p "enter your name? "  NAME
echo "hi, ${NAME}, nice to meet you"
```

# conditional

## if statement
>make sure there is a space between [ ]

```shell

NAME=Abc

if [ "${NAME}" == "ABC" ] #leave space between [ and ]
then
  echo "nice"
elif [ "${NAME}" == "Abc" ]
then
  echo "not so bad"
else
  echo "bad"
fi
```

# comparison

+ -eq: equal
+ -ne: not equal
+ -gt: great thn
+ -ge: greater or equal
+ -lt: less than
+ -le: less than or equal

```shell
NUM1=3
NUM2=5
if [ "${NUM1}" -eq "${NUM2}" ]
then
  echo NUM1 is equal to NUM2
elif [ "${NUM1}" -ne "${NUM2}" ]
then
  echo NUM1 is NOT equal to NUM2
elif [ "${NUM1}" -gt "${NUM2}" ]
then
  echo NUM1 is bigger then NUM2
elif [ "${NUM1}" -ge "${NUM2}" ]
then
  echo NUM1 is bigger or equal to NUM2
elif [ "${NUM1}" -lt "${NUM2}" ]
then
  echo NUM1 is less than NUM2
elif [ "${NUM1}" -ge "${NUM2}" ]
then
  echo NUM1 is less than or equal to NUM2
else
  echo can not compare
fi
```

# file conditions
+ -d file: True if the file is a directory
+ -e file: True if the file exists (not that this is not particularly portable, thus -f is generally used)
+ -f file: True if the provided string is a file
+ -g file: True if the group id is set on a file
+ -f file: True if the file is readable
+ -s file: True if the file has a non-zero size
+ -u file: True if the user id is set on a file
+ -w file: True if the file is writeable
+ -x file: True if the file is executable

```shell
FILE="test.txt"
if [ -f "${FILE}" ]
then
  echo ${FILE} is a file
else
  echo ${FILE} is not a file
fi

FILE="test.txt"
if [ -e "${FILE}" ]
then
  echo ${FILE} is exist
else
  echo ${FILE} is not exist
fi
```

# case statement

```shell
read -p "are you 21 or over? " ANSWER

case "${ANSWER}" in  #begin of case statement
  [yY] | [yY][eE][sS]) # Condition: if the answer is y/Y or yes/YES, don't forget the )
    echo "you can have a beer :)" # statement
    ;; # end of case
  [nN] | [nN][oO])
    echo "you can NOT DRINK"
    ;;
  *) # this works as default:
    echo "please enter y/yes or n/no"
esac  #end of case statement
```


# for loop
>something like python
```shell
NAMES="Alice Brad Kevin Mark"

for NAME in ${NAMES}
  do
    echo hi, ${NAME}
done
```

# for loop for rename files
>create list of testing files: f1.txt f2.txt f3.txt
> `touch f1.txt f2.txt f3.txt`
```shell
FILES=$(ls ax-*.txt)  # get input from command
for FILE in ${FILES}
  do
    if [ -f ${FILE} ]
    then
      echo rename file ${FILE}
      mv ${FILE} fx-${FILE}
    fi
done
```
# while loop
>read file line by line, and add line number to each line
> < is input, >> is output
```shell
LINE=1
while read -r CURRENT_LINE # CURRENT_LINE is the content of current line
  do 
    echo "${LINE}: ${CURRENT_LINE}"
    ((LINE++))
done < "./fileToRead.txt" >> "newFileWithLineNu.txt" #name of the file going to read
```

# function

```shell
#define func
function sayHello(){
    echo "Hello"
}

sayHello #run func
```

## function with params

```shell
function greet(){
    # $1 is first param, $2 is the second param
    echo "Hello, I am $1 and I am $2"
}

greet "Bo" "99"  # calling func with position params
```

# string replace 

```bash
branch=a/b-c.d@e$f%g!h-i_j+k=m
echo ${branch}
# will not replace alph-numeric and - _ . 
# convert rest to -
stra=${branch//[^[:alnum:]-_.]/-}

echo ${stra}
```


## sed replace
```bash
# replace / _ . to -
$(echo ${var} | sed -e 's/[/_.]/-/g)
```