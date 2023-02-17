# 4.1 Variable Substitution
the name of a variable is a placeholder for its value, the data it holds. referencing (retrieving) its value is called variable substitution

## `$`
let us carefully distinguish between the name of a variable and its value. if variable is the name of a variable, then $variable is a reference to its value. the data item it contains.

```bash
variable1=23

echo variable1  # variable1

echo $variable1 # 23
```

the only times a variable appears 'naked' -- without the $ prefix -- is when declared or assigned, when unset, when exported, in an arthmetic expression within double parentheses `((...))` or in the special case of a variable representing a signal. assignment may be with an=, in a read statement(e.g. `var1=27`), and at the head of a loop(e.g. `for var2 in 1 2 3`)

enclosing a referenced value in double quotes(`"..."`) does not interfere with variable substitution. this is called partial quoting, sometimes refered to as 'weak quoting' using single quotes(`'...'`) causes the variable name to be used literally, and no substitution will take place. this is full/strong quoting.

>note that $variable is actually a simplified form of ${variable}. in contexts where the $variable syntax causes an error, the longer form may work

>example 4-1 variable assignment and substitution
```bash
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
exit 0
```
An uninitialized variable has a null value -- no assigned value at all 
```bash
if [ -z "$unassigned" ]
then
    echo "\$unassigned is NULL"
fi
```
using a variable before assigning a value to it may cause problem.
it is nevertheless possible to perform arthmetic operations on an uninitialized variable
```bash
echo "$uninitialized"       # (blank line)
let "uninitialized += 5"    # add 5 to it
echo "$uninitialized"       # 5

# conclusion:
# an unitialized variable has no value
# however it evaluates as 0 in an arthmetic operation.
```

# 4.2 Variable assignment
## `=`

the assignment operator (no space before and after)
>do not confuse this with `=` and `-eq`, which test rather than assign
>note that `=` can  be either an assignment or a test operator, depending on context

>example  4-2. plain variable assignment
```bash
#!/bin/bash
# naked variable
echo

# when is a variable "naked", i.e., lacking the '$' in front?
# when it is being assigned, rather then referenced.

# assignment
a=879
echo "the value of \"a\" is $a."


# assignment using 'let
let a=16+5
echo "The value of \"a\" is now $a."

echo

# in a for loop,(really, a type of disguised assignment):
echo -n "values of "\a\" in the loop are: "
for a in 7 8 9 11
do 
    echo -n "$a "
done

echo; echo

# in a 'read' statement (also a type of assignment):
echo -n "enter \"a\" "
read a
echo "The value of \"a\" is now $a. "

echo 

exit 0
```

> example 4-3 variable assignment, plain and fancy

```bash
#!/bin/bash

a=23
echo $a
b=$a
echo $b

# now, getting a litter bit fancier (command substitution).

a=`echo Hello!`  # assigns result of 'echo' command to 'a'
# looks like `` is equals to $()
# so above is equals a=$(echo Hello)

# note that including an exclamation mark(!) within a
# command substitution construct will not work from the command-line
# since this triggers the bash history mechainism
# Inside a script, however, the history functions are disabled by default

a=`ls -l`       # assigns result of 'ls -l' command to 'a'
echo $a         # unquoted, howver, it removes tabs and newline
# root@4986848167d7:/codes/linuxCommands/shell-scripting# echo $a
# total 72 -rw-r--r-- 1 root root 29246 Feb 16 16:00 advanced_bash_scripting_guide_c3.md -rw-r--r-- 1 root root 2975 Feb 16 16:29 advanced_bash_scripting_guide_c4.md -rwxr-xr-x 1 root root 403 Feb 16 12:01 background-loop.sh -rwxr-xr-x 1 root root 2664 Feb 16 17:10 ex9.sh -rw-r--r-- 1 root root 50 Feb 15 09:55 myscript.sh -rw-r--r-- 1 root root 3819 Feb 15 09:55 readme.md -rwxr-xr-x 1 root root 502 Feb 16 15:30 rubout.sh -rwxr-xr-x 1 root root 815 Feb 16 12:02 set_variable.sh -rwxr-xr-x 1 root root 276 Feb 16 10:29 test.sh -rwxr-xr-x 1 root root 73 Feb 17 11:27 test_exclamation_mark.sh -rwxr-xr-x 1 root root 15 Feb 16 10:44 uppercase.sh


echo "$a"       # the quoted variable preserves whitespace
# root@4986848167d7:/codes/linuxCommands/shell-scripting# echo "$a"
# total 72
# -rw-r--r-- 1 root root 29246 Feb 16 16:00 advanced_bash_scripting_guide_c3.md
# -rw-r--r-- 1 root root  2975 Feb 16 16:29 advanced_bash_scripting_guide_c4.md
# -rwxr-xr-x 1 root root   403 Feb 16 12:01 background-loop.sh
# -rwxr-xr-x 1 root root  2664 Feb 16 17:10 ex9.sh
# -rw-r--r-- 1 root root    50 Feb 15 09:55 myscript.sh
# -rw-r--r-- 1 root root  3819 Feb 15 09:55 readme.md
# -rwxr-xr-x 1 root root   502 Feb 16 15:30 rubout.sh
# -rwxr-xr-x 1 root root   815 Feb 16 12:02 set_variable.sh
# -rwxr-xr-x 1 root root   276 Feb 16 10:29 test.sh
# -rwxr-xr-x 1 root root    73 Feb 17 11:27 test_exclamation_mark.sh
# -rwxr-xr-x 1 root root    15 Feb 16 10:44 uppercase.sh

exit 0
```

variable assignment using the $(...) mechanism ( a newer method thant backquotes) this is likewise a form of command substitution
```shell
# From /etc/rc.d/rc.local
R=$(cat /etc/redhat-releases)
arch=$(uname -m)

```

# 4.3 bash variables are untyped
unlike many other programming languages, bash does not segregate its variables by "type".
essentially, bash variables are character string, but, depending on context. 
bash permits arithmetic operations and comparisons on variables. the determining factor is whether the value of a variable contains only digits.


> Example 4-4 Integer or sting?
```bash
#!/bin/bash
# int-or-string.sh

a=2334      # integer
let "a +=1"
echo "$a=$a "       # a = 2335, still integer
echo 

b=${a/23/BB}        # substitute "bb" for "23". 
                    # this transform $b into a string
echo "b = $b"       # b = BB35   2335 23 / BB = BB35

declare -i b        # declaring it an integer doesn't help
echo "b = $b"       # $b = BB35

let "b += 1"        # BB35 + 1
echo "b = $b"       # b = 1
echo                # bash sets the integer value of a string to 0.

c=BB34
echo "c = $c"       # c = BB34
d=${c/BB/23}        # Substitute "23" for "BB".
echo "d = $d"       # d = 2334
let "d += 1"        # 2334 + 1
echo "d = $d"       # d = 2335
echo

# what about null variables?
e=''                # ... or e="" ... or e=
echo "e = $e"       # e = 
let "e += 1"        # Arithmetic operations allowed on a null variables
echo "e = $e"       # e = 1
echo                # null variable transformed into an integer.


# what about undeclared variables?
echo "f = $f"       # f = 
let "f += 1"        # arithmetic operations allowed
echo "f = $f"       # f = 1
echo                # undeclared variable transformed into an integer as 0

# however ...
let "f /= $undecl_var"     # devide by zero?
# let: f/= : syntax error: operand expected (error token is " ")
# syntax error! variable $nudec1_var is not set to zero here!

# but still ...
let "f /= 0"
# let: f /= 0 : division by 0 (error token is "0")
# expected behavior

# bash (usually) sets the integer value of null to zero
# when performing an arithmetic operation
# but, don't try this at home folks
# it's undocumented and probably non-portable behavior

# conclusion: variable in bash are untyped
# with all attendant consequences
exit $?
```

untyped variables are both a blessing and a curse. they permit more flexbility in scripting and make it easier to gind out lines of code( and give you enough rope to hang yourself). however, they likewise permit subtle errors to creep in and encourage sloppy programming habits
to lighten the burden of keeping track of variable types in a script. bash does permt declaring variable.

# 4.4 Special Variable Types
## local variables
variables visible only within a code block or functions

## Environmental variables
variables that affect the behavior of the shell and user interface

>in a more general context, each process has an environment, that is a group of variables that the process may reference. in this sense, the shell behaves like any other process.
every time a shell starts, it creates shell variables that correspond to its own environmental variables. updating or adding new environmental variables causes the shell to update its environment, and all the shells child processes(the commands it executes) inherit this environment.

>the space allotted to the environment is limited. creating too many environmental variables or ones that use up excessive space may cause problems.
```shell
bash$ eval "`seq 10000 | sed -e 's/.*/export var&=ZZZZZZZZZZZZZZ/'`"
bash$ du
bash: /usr/bin/du: argument list too long
```
Note: this "error" has been fixed, as of kernel version 2.6.23

if a script sets environment variables, they need to be exported. that is, reported to the environment local to the script. this is the function of the export command.

> a script can export variables only to child processes. that is only to commands or processes which that particular script initiates. a script invoked from the command-line can not exprot variables back to the command-line environment. child processes can not export variables back to the parent processes that spawned them.
>
> **Definition:** a child process is a subprocess launched by another process. its parent 


## Positional Parameters
arguments passed to the script from the command line: $0 $1 $2 $3 ...

after 9 the arguments must be enclosed in brackets: ${10}, ${11}, ...

$0 is the name of the script itself. $1 is the first argument and so on
the special variables $* and $" denote all the positional parameters

>Example 4-5 Positional Parameters
```bash
#!/bin/bash

# call this script with at least 10 parameters, for example
# ./scriptname 1 2 3 4 5 6 7 8 9 10

MINPARAMS=10

ehco 
echo "The name fo this script is '|$0\"."
# adds ./ for current directory

echo "The name of this script is \"`basename $0`\"."
# Scripts out path name info (see 'basename')

echo

if [ -n "$1" ]      # tested variable is quoted.
then
    echo "Parameter #1 is $1"       # need quotes to escape #
fi


if [ -n "$2" ]
then
    echo "Parameter #2 is $2"
fi

# ...


if [ -n "${10}" ]
then
    echo "Parameter #10 is ${10}"
fi

echo "-------------------------------"
echo "all the command-line parameter are: "$*""

if [ $# -lt "$MINPARAMS" ]
then
    echo; echo "This script needs at  least $MINPARAMS command-line  arguments!"
    echo "only $# given"
fi

echo; 
exit 0
```

bracket notation for positional parameters leads to a fairly simple way of referencing the last argument passed to a script on the command-line. this also requires indicrect referencing
```bash
args=$#     Number of args passed
lastarg=${!args}
# note: this is an *indirect referenc* to $args ...

# or: lastarg=${!#}
# this is an indirect reference to the $# variable
Note that lastarg={!$#}  doesn't work
```

some scripts can perform different operations, depending on which name they are invoked with. For this to work, the script needs to check $0, the name it was invoked by. there must also exist symbolic links to all the alternate names of the script.

>info: if a script expects a command-line parameter but is invoke without one. this may cause a null variable assignment, generally an undersirable result. one way to prevent this is to append an extra character to both sides of the assignment statement using the expected positional parameter.

```bash
variable1_=$1_      # rather than variable1=$1
# this will prevent an error, even if positional parameter is absent


critical_argument01=$variable1_

# the extra character can be stripped off later, like so.
variable1=${variable1_/_/}
# side effects only if $variable1_ begins with an underscore.
# this uses one of the parameter substitution templates discussed later
# leaving out the replacement pattern results  in a deletion.

# a more straightforward way of dealing with this is
# to simply test whether expected positional parameters have been passed
if [ -z $1 ]
then
    exit $E_MISSING_POS_PARAM
fi

# however, as fabian point out,
# the above method may have unexpected side-effects.
# a better method is parameter substitution:
#   ${1:-$DefaultVal}
# see the Parameter substition section
# in the variable revisited chapter
```

>example 4-6 wh, whois domain name lookup
```bash
#!/bin/bash
# ex18.sh

# does a 'whois domain-name' lookup on any of 3 alternate servers:
# ripe.net, cw.net, radb.net

# place this script -- rename 'wh' -- in /usr/local/bin


# requires symbolic links:
# ln -s /usr/local/bin/wh /usr/local/bin/wh-ripe
# ln -s /usr/local/bin/wh /usr/local/bin/wh-apnic
# ln -s /usr/local/bin/wh /usr/local/bin/wh-tucows

E_NOARGS=75

if [ -z "$1" ]
then 
    echo "Usage: `basename $0` [domain-name]"
    exit $E_NOARGS
fi

# check script name and call proper server.
case `basename $0` in       # or: case ${0##*/} in
    "wh"        ) whois $1@whois.tucows.com;;
    "wh-ripe"   ) whois $1@whois.ripe.net;;
    "wh-apnic"  ) whois $1@whois.cw.net;;
    *           ) echo "Usage: `basename $0` [domain-name]" ;;
esac

exit $?
```

this shift command reassigns the positional parameters, in effect shifting them to the left one notch
`$1 < --- $2, $2< ---$3, $3<--- $4, etc`
the old $1 disppears, but $0(the script name) does not change. if you use a large number of positional parameters to a script, shift lets you access thosee past 10, although {bracket} notation also permists this.


> example 4-7. Using shift
```bash
#!/bin/bash
# shft.sh: using shift to step through all the positional parameters

# name this script something like shft.sh,
# and invoke it with some parameters
# e.g.:
# `sh shft.sh a b c def 83 barndoor`

until [-z "$1" ]  # until all parameters used up ...
do 
    echo -n "$1 "
    shift
done

echo 

# but, what happens to th4e 'used-up' parameters?
echo "$2"
# nothing echoes
# when $2 shifts into $1 (and there is no $3 to shift into $2)
# so, it is not parameter *copy*, but a "move"

exit
```

the `shift` command can take a numerical parameter indicating how many positions to shift.
```bash
# shift-past.sh
shift 3         # shift 3 positions
# n=3; shift $n
# has the same effect

echo "$1"

exit 0

# ==================================
# $ sh shift-past.sh 1 2 3 4 5 
# 4

# however, as points out
# attempting a shift past the number of positional parameters ($#) returns an exit status of 1,
# and the positional parameters themselves do not change.
# this means possibly getting stuck in an endless loop ...
# for example
#     until [ -z "$1" ]
#     do
#         echo -n "$1"
#         shift 20        # if less then 20 pos params, 
#                         # the loop never ends

# when i ndoubt, add a sanity check
# shift 20 || break

```