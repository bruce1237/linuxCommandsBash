# 3 Special Characters
what make a s character special?

if it has a meaning beyond it's literal meaning, a meta-meaning, then we refer to it as a special character. along with commands and keywords, special characters are building blocks of bash scripts.

# Special character found in scripts and elsewhere

## `#` comments. 
lines beginning with a `#`(with exception of `#!`) are comments and will not be executed.

examples
```bash
# this line is a comment
echo "A comment will follow." # comment here, note the white space before #
    # a tab precedes this comment

initial=( `cat "$startfile" | sed -e '/#/d' | tr -d '\n' |\
# delete lines containing '#' comment character.
           sed -e 's/\./\. /g' -e 's/_/_g'` )
# Excerpted from life.sh script
```

a command may not follow a comment on the same line, there is no method of terminating the comment, in order for 'live code' to begin on the same line. use a new line for the next command. of course, a quoted or an excaped # in an echo statement does not begin a comment likewise, a # appears in certain parameter-subsitution constructs and in numerical constant expressions.
```bash
echo 'the # here does not begin a comment. '
echo "the # here does not begin a comments. "
echo the \# here does not begin a comment.
echo the # here begins a comment.
echo ${PATH#*:} # parameter substitution, not a comment.
echo $(( 2#101011 ))  # base conversion, not a comment.
```
>Note: certain pattern matching operations also use the #.
>
>the standard quoting and escape characters `"'\` escape the #

## `;` command separator [semicolon]. 
permits putting two or more commands on the same line.
```bash
echo hello; echo there

if [-x "$filename" ]; then # note the space after the semicolon.
    echo "file $filename exists."; cp $filename $filename.bak
else
    echo "file $filename not found."; touch $filename 
fi; echo "File test complete."
```
>Note: sometime needs to escape `;`

## `;;` terminator in a case option [double semicolon]
```bash
case "$variable" in 
    abc) echo "\$variable = abc" ;;
    xyz) echo "\$variable = xyz" ;;
esac
```

## `;;&,;&` terminators in a case option (version 4+ of bash)
## `.` 'dot' command [period]. equivalent to source this is a bash builtin.
## `.` dot as a component of a filename. 
when working with filenames, a leading dot is the prefix of a hidden file, a file that an ls will not normally show.
```shell
bash$ touch .hidden-file
bash$ ls -l	      
total 10
 -rw-r--r--    1 bozo      4034 Jul 18 22:04 data1.addressbook
 -rw-r--r--    1 bozo      4602 May 25 13:58 data1.addressbook.bak
 -rw-r--r--    1 bozo       877 Dec 17  2000 employment.addressbook


bash$ ls -al	      
total 14
 drwxrwxr-x    2 bozo  bozo      1024 Aug 29 20:54 ./
 drwx------   52 bozo  bozo      3072 Aug 29 20:51 ../
 -rw-r--r--    1 bozo  bozo      4034 Jul 18 22:04 data1.addressbook
 -rw-r--r--    1 bozo  bozo      4602 May 25 13:58 data1.addressbook.bak
 -rw-r--r--    1 bozo  bozo       877 Dec 17  2000 employment.addressbook
 -rw-rw-r--    1 bozo  bozo         0 Aug 29 20:54 .hidden-file
	        
```            
when considering directory names, a single dot represents the current working directory, and two dots denote the parent directory.

the dot often appears as the destination directory of a file movement command, in this context means current directory.
```bash
cp /home/bo/* .
```

## `.` dot character match
when matching characters, as part of a regular expression a dot matches a single character.

## `"` partial quoting [double quote]
"string" preserves (from interpretation) most of the special character within string

## `'` full quoting [single quote]
string preserves all special characters within string, this is a stronger from an quoting than "string"

## `,` comma operator
the comma operator links together a series of arithmetic operations all are evaluated, but only the last one is return.
```bash
let "t2 = (( a = 9, 15 /3 ))"
# set a=9 and t2 = 15/3
```

the comma operator can also concatenate strings.
```bash
for file in /{,usr/}bin/*calc
# find all executable files ending in "calc"
# in /bin and /usr/bin directories

do
    if [-x "$file" ]
    then
        echo $file
    fi
done

# /bin/ipcalc
# /usr/bin/kcalc
# /usr/bin/oidcalc
# /usr/bin/oocalc
```

## `,, ,` lowercase conversion in parameter substitution 
```bash 
str=STRING
echo ${str,,} # string
```

## `\` escape [backslash]
a quoting mechanism for single characters, \x escapes the character x this has the effect of quoting x,  equivalent to 'x' the `\` may  be used to quote " and ', so they are expressed liiterally.

## `/` filename path separator [forward slash]
separates the components of a filename  as in /home/bozo/project/)

## ``` ` ``` command substitution 
the command construct makes available the output of command for assignment to a variable this si know as backquotes or backticks.

## `:` null command [colon]
this is the shell equivalent of a NOP (no op, a do-nothing operationg) it may be considered a synonym for the shell builtin true. the `:` command is itself a bash builtin and its exist status is true(0).
```bash
:
echo $? #0
```

endless loop:
```bash
while :
do
    operation-1
    operation-2
    ...
    operation-n
done

# same as :
# while true
# do
#     ...
# done
```

placeholder in if/then test:
```bash
if condition
then : # do nothing and branch ahead
else # or else ...
    take-some-action
fi
```
provide a placeholder where a binary operation is expected
```bash
: ${username='whoami'}
# ${username='whoami'}
# gives an error whithout the leading : unless "username" is a command or builtin ...

: ${1?"usage: $0 ARGUMENT"} # from "useage-message.sh example secript.
```

provide a placeholder where a command is expected in a here document 
evaluate string of variables using parameter substitution
```bash
: ${HOSTNAME?} ${USER?} ${MAIL?}
# prints error message
# if one or more of essential environmental variable not set
```

variable expansion / substring replacement

in combination with the > redirection operator, truncates a file to zero length, without changing its permissions. if the file did not previously exist, create it
```bash
: > data.xxx # file data.xx now empty
# same effect as cat /dev/null > data.xx
# however, this does not fork a new process, since ":" is a builtin.
```

in combination with the >> redirection operator, has no effect on a pre-existing target file (: >> target_file). if the file did not previously exist, creates it.

may be used to begin a comment line, although this is not recommended. using # for a comment turns off error checking for the remainder or that line, so almost anything may appear in a comment. however, this is not the case with : . 
```bash
: this is a comment that generates an error, ( if [ $x -eq 3] ).
```
the `:` serves as a filed separator, i n /etc/passwd, as in the $PATH variable
```bash
echo $PATH
/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
```
a colon is acceptable as a function name.
```bash
:()
{
    echo "The name of this function is "$FUNCNAME" "
    # why use a colon as a function name?
    # it's a way of obfuscating your code
}
:
# output: The nam of this function is :
```
this is not portable behavior, and therefore not a recommended practice. in fact, more recent releases of bash do not permit this useage. an underscore_works though.

a colon can serve as a placeholder in an otherwise empty function.
```bash
not_empty ()
{
    :
} # Contains a : (null command), and so is not empty
```

## `!` reverse (or negate) the sense of a test or exist status [bang]
the `!` operator inverts the exist status of the command to which it is applied. it also inverts the meaning of a test operator. this can, for example, change the sense of equal(=) to not-euqal(!=). the `!` operator is a bash keyword.

in a different context, the `!` also appears in indirect variable references. 

in yet another context, from the command line, the ! invokes the bash history mechanism. note that within a script, the history mechanism is disabled


## `*` wild card [asterisk]. 
the `*` character serves as a wild card for filename expansion in globbing. by itself, it matches every filename in a given directory.
```bash
echo *  # same as ls 
```
the `*` also represents any number or zero characters in a regular expression

## `*` arithmetic operator
in the context of arithmetic operators, the * denotes multiplication.

** a double asterisk can represent the exponentiation operator or extended file-matching globbing.

## `?` test operator
within certain expressions, the ? indicates a test for a condition.
in a double-parentheses construct. the ? can serve as an element of a C-style trinary operator
condition?result-if-true:result-if-false
```bash
(( var- 0 var1<98?9:21 ))

# it equals to 
# if [ "$var1" -lt 98 ]
# then
#     var0=9
# else
#     var0=21
# fi
```

## `?` wild card.

the ? character serves as a single-character "wild card" for  filename expansion in globbing, as wwell as representing one character in an extended regular expression.

## `$` variable substitution
contents of a variable
```bash
var1=5
var2=23skidoo
echo $var1  # 5
echo $var2  # 23skidoo
```
a $ prefixing a variable name indicates the value the variable holds

## `$` end-of-line
in a regular expression a $ addresses the end of a line fo text

## `${}` Parameter subsitution

## `$'...'` Quoted string expansion.
this construct expands single or multiple escaped octal or hex values into ASCII or unicode characters

## `$*, $@` positional parameters

## `$?` exit status variable
the $? variable holds the exit status of a command, a function or of the script itself


## `$$` processID variable
the $$ variable holds the process id of the script in which it appears.

## `()` command group
```bash
(a=hello; echo $a)
```
a listing of commands within parentheses start a subshell
variables inside parentheses, within the subshell, are not visible to the rest of the script. the parent process, the script, cannot read variables created in the child process, the subshell.
```bash
a=123
( a=321; )

echo "a = $a"  # a = 123
# "a" within parentheses acts like a local variable
```

array initializtion
```bash
array=(element1 element2 element3)
```

brace expansion.
```bash
echo \"{These,words,are,quoted}\"  # " prefix and suffix
# "these" "words" "are" "quoted"

cat {file1,file2,file3} > combined_file
# comcatenates the files file1 file2 and file3 into combined_file

cp file22.{txt,backup}
# copies "file22.txt" to "file22.backup"
```
a command may act upon a comma-separated list of file specs within braces. filename expansion applies to the file specs between the braces.

>NOTE: Spaces allowed within the barces unless the spaces are quoted or escaped.
```bash
echo {file1,file2}§ :{\ :{\ A," B" ,' c'}
```

## `{a..z}` Extended brace expansion
```bash
echo {a..z} # a b c d e f g h i j k l m n o p q r s t u v w x y z
# Echoes characters between a and z.

echo {0..3} # 0 1 2 3
# echos characters between 0 and 3

base64_charset=({A..Z} {a..z} {0..9} + / = )
# initializing an array, using extended brace expansion
```

## `{}` block of code [curly brackets]
also referred to as an inline group, this construct, in effect, creates an anonymous function. however, unlik in a stand function, the variables inside a code block remian visible to the remainder of the script
```bash
{ local a; a=123; }
# local: can only be used in a function
```
the code block enclosed in braces may have I/O redirected to and from it.

>Example 3-1 Code blocks and I/O redirection
```bash
#!/bin/bash
# reading lines in /etc/fstab.
File=/etc/fstab

{ read line1
read line2
} < $File

echo "First line in $File is: "
echo "$line1"
echo 
echo "Second line in $File is: "
echo "$line2"

exit 0
```

>Example 3-2 saving the output of a code block to a file
```bash
#!/bin/bash
# rpm-check.sh
# queries an rpm file for description , listing
# and whether it can be installed
# saves output to a file
# this script illustrates using a code block.

SUCCESS=0
E_NOARGS=65

if [ -z "$1" ]
then
    echo "Usage: 'basename $0' rpm-file"
    exit $E_NOARGS
fi

{ # begin code block.
echo 
echo "Archive Description:"
rpm -qpi $1 # query description.
echo
echo "Archive Listing:"
rpm -qpl $1 # Query listing
echo
rpm -i --test $1 # Query whether rpm file can be installed

if [ "$?" -eq $SUCCESS ]
then
    echo "$1 can be installed. "
else
    echo "$1 can not be installed. "
fi
echo  
} > "$1.test" # end code block

echo "Results of rpm test in file $1.test"

# see rpm man page for explanation of options
exit 0
```
unlike a command group within (parentheses), as above, a code block enclosed by {braces} will not normally launch a subshell
it is possible to iterate a code block using a non-standard for-loop


## `{}` placeholder for text
used after xargs -i (replace strings option) the {} double curly brackets are a placeholder for output text.

```bash
ls . | xargs -i -t cp ./{} $1
```

## `{}\;` pathname
mostly used in find constructs this is not a shell builtin
>Definition: A pathname is a filename that includes the complete path.

## `[]` test
tests expression between []. not that [ is part of the shell builtin test(and a synonym for it) not a link to the external command /usr/bin/test

## `[[ ]]` test
test expression between [[ ]] more flexible than the single-bracket [] test. this is a shell keyword

## `[]` array element
in the context of an array. brackets set off the numbering of each element of that array
```bash
Array[1]=slot_1
echo ${Array[1]}
```

## `[ ]` range of characters
as part of a regular expression, brackets delineate a range of characters to match.

## `$[ ... ]` integer expransion
evaluate integer expression between $[]
```bash
a=3
b=7
echo $[$a+$b] # 10
echo $[$a*$b] # 21
```

## `(( ))` integer expansion
expand and evaluate integer expression between (( ))

## `> &> >& >> < <> ` redirection
scriptname > filename redirects the output  of scriptname to file filename. overwrite filename if it already exists
command &>filename redirects both the stdout and the stderr of command to filename
> this is useful for suppressing output when testing for a condition. 
> for example, let us test whether a certain command exists
```bash
type bogus_command &>/dev/null

echo $?
```
or in a script
```bash
command_test () { type "$1" &>/dev/null; }

cmd=rmdir # legitimate command
command_test $cmd; echo $? # 0

cmd=bogus_command # illegitimate command
command_test $cmd; echo $? # 1
```

> command >&2 redirects stdout of command to stderr.
> scriptname >>filename appeds the output of scriptname to file filename. if filename does not exist, it is created.

 process substitution
 (command)>
 <(command)
 in a different context, the "<" and ">" characters act as string comparison operators.
 in yet another context, the "<" and ">" characters act as integer comparison operators

 ## `<<`
 redirection used in a here document

 ## `<<<` redirection used in a here string

 ## `<,>` ASCII comparison
 ```bash
 veg1=carrots
 veg2=tomatoes

 if [[ "$veg1" < "$veg2" ]]
 then
    echo "Although $veg1 precede $veg2 in the dictionary,"
    echo -n "this does not necessarily imply anything "
    echo "about my culinary preferences."
else
    echo "what kind of dictionary are you using, anyhow?"
fi
```

## `\<, \>` word boundary in a regular expression
` grep '\<the\>' textfile`

## `|` pipe
passes the output (stdout) of a previous command to the input(stdin)_ of the next one, or to the shell. this is a method of chining commands together.
```bash
echo ls - l | sh
# passes the output of "echo ls -l" to the shell.
#  with the same result as a simple "ls -l"

cat *.lst | sort | uniq
# merges and sorts all ".lst" files, then deletes duplicate lines.
```
>A pipe, as a classic method of interprocess communication, sends the stdout of one process ot the stdin of another. in a typical case, a command, such as cat or echo, pipes a stream of data to a filter, a command that transforms int input for processing.
> ` cat $filename1 $filename2 | grep $search_word `
>for an interesting note on the complexity of using UNIX pipes
the output of a command or commands may be piped to a script
```bash
#!/bin/bash
#  uppercase.sh: changes in put to uppercaser.
tr 'a-z' 'A-Z'
# letter ranges must be quoted
to prevent filename generation from single-letter filename
exit 0
```
now let us pipe the output of "ls -l" to this script
```
root@4986848167d7:/codes/linuxCommands/shell-scripting# ls -l| ./uppercase.sh 
TOTAL 32
-RW-R--R-- 1 ROOT ROOT 15356 FEB 16 10:30 ADVANCED_BASH_SCRIPTING_GUIDE.MD
-RW-R--R-- 1 ROOT ROOT    50 FEB 15 09:55 MYSCRIPT.SH
-RW-R--R-- 1 ROOT ROOT  3819 FEB 15 09:55 README.MD
-RWXR-XR-X 1 ROOT ROOT   276 FEB 16 10:29 TEST.SH
-RWXR-XR-X 1 ROOT ROOT    15 FEB 16 10:44 UPPERCASE.SH
```

the stdout of each process in a pipe must be read aas the stdin of the next. if this is not the case, hte data stream will block, and the pipe will not behave as expected.

A pipe runs as a child process, and therefore cannot alter script variables
```bash
variable='initial_value"
echo "new_value" | read variable
echo "variable = $variable" # variable= initial_value
```
if one of the commands in the pipe aborts, this prematurely terminates execution of the pipe. called a a broken pipe. this condition send a SIGPIPE signal.

## `>|` force redirection (even if the noclobber option is set)
this will forcibly overwrite an existing file

## `||` OR logical operator 
in a test construct, the || operator causes a return of 0(success) if either of the linked rtest conditions is true

## `&` run job in background
a command followed by an & will run in the background
```bash
sleep 10 &
[1] 850
[1]+  Done                    sleep 10
```
within a script, commands and even loops may run in the background

> example 3-3 running a loop in the background
```bash
#!/bin/bash
# background-llp.sh
for i in 1 2 3 4 5  6 7 8 9 10   # first loop
do 
    echo -n "$i "
done & # run this loop in background will sometimes execute after second loop.

echo # this 'echo' somtime will not display.

for i in 11 12 13 14 15 16 17 18 19 20  # second loop
do 
    echo -n "$i"
done

echo # this 'echo' sometime will not display

# ======================================================

# The expected output from the script:
# 1 2 3 4 5 6 7 8 9 10 
# 11 12 13 14 15 16 17 18 19 20 

# Sometimes, though, you get:
# 11 12 13 14 15 16 17 18 19 20 
# 1 2 3 4 5 6 7 8 9 10 bozo $
# (The second 'echo' doesn't execute. Why?)

# Occasionally also:
# 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20
# (The first 'echo' doesn't execute. Why?)

# Very rarely something like:
# 11 12 13 1 2 3 4 5 6 7 8 9 10 14 15 16 17 18 19 20 
# The foreground loop preempts the background one.

exit 0

#  Nasimuddin Ansari suggests adding    sleep 1
#+ after the   echo -n "$i"   in lines 6 and 14,
#+ for some real fun.
```
> A command run in the background within a script may cause the script to hang, waiting for a keystroke. fortunately, there is a remedy for this. just put `wait` after `&`

## `-` option, prefix
option flag for a command or filter. prefix for a default parameter in parameter substitution.

`COMMAND -[Option1][Option2][...]`

`ls -l`

`sort -dfu $filename`

```bash
if [ $file1 -ot $file2 ]
then
    echo "file $file1 is older then $file2. "
fi

if [ "$a" -eq "$b" ]
then
    echo "$a is equal to $b."
fi

if [ "$c" -eq 24 -a "$d" -eq 47 ]
then
    echo "$c equals 24 and $d equals 47."
fi

param2=${param1:-$DEFAULTVAL}
```

## `--` the double-dash --prefix long(verbatim) options to commands
`sort --ignore-leading-blanks`
used with a bash builtin, it means the end of options to that particular command.
>this provides a handy means of removing files whose names begin with a dash
```bash
ls -l
-rw-r--r-- 1 bozo bozo 0 Nov 25 12:29 -badname

rm -- -badname

ls -l
total 0
```
the double-dash is also used in conjunction with set
`set -- $variable`
>example 15-18 reassigning the positional parameters
```bash
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
```

## `-` redirection from/to stdin or stdout [dash]
```bash
cat - 
abc
abc
...
Ctl-D
```

as expected, cat - echoes stdin, in this case keyboarded user input to stdout but does I/O redirection using - have real-world applications?
```bash
(cd /source/directory && tar cf - . ) | (cd /dest/directory && tar xpvf -)
# move entire file three from one directory to another

# 1) cd /source/directory 
#     source directory, where the files to be moved are.
# 2) &&
#     "and-list" : if the 'cd' operation successfull, 
#      then execute the next command
# 3) tar cf - .
#     the 'c' option 'tar' archiving command creates a new archive, 
#     the 'f' (file) option, followed by '-' designates the target file as stdout, 
#     and do it in current directory tree('.')
# 4) |
#     piped to ...
# 5) (...)
#     a subshell
# 6) cd /dest/directory
#     change to the destination directory
# 7) &&
#     "and-list" as above
# 8) tar xpvf -
#     unarchive('x'), preserve ownership and file permission ('p').
#     and send verbose messages to stdout ('v')
#     reading data from stdin ('f' followed by '-' ).
    
#     NOTE that 'x' is a command, and 'p', 'v' 'f' are options.


# more elegant than, but equivalent to :

# cd cource/directory
# tar cf - . | (cd ../dest/directory; tar xpvf -)

# also having same effect:
# cp -a / source/directory/* /dest/directory
#     or:
# cp -a /source/directory/* /source/directory/.[^.]* /dest/directory
#     if there are hidden file in /source/directory.    
```
>note that in this context the '-' is not itsef a bash operator, but rather an option recognized by certain UNIX utilities that write to stdout, such as tar cat etc

` echo "whatever" | cat -`

where a filename is expected, - redirects output to stdout(sometimes seen with tar cf) or accepts input from stdin, rather than from a file. this is a method of using a file-orented utility as a filter in a pipe.

and a '-' for a more useful result. this causes the shell to await user input.
```shell

bash$ file -
abc
standard input:              ASCII text



bash$ file -
#!/bin/bash
standard input:              Bourne-Again shell script text executable
```
now the command acccepts in put from stdin and analyzes it.

the '-' can be used to pipe stdout to other commands this permits such stunts as prepending lines to a file.

using `diff` to compare a file with a section of another:
`grep linux file1 | diff file 2 -`
the above command grep all the lines which contain 'linux',
then pipe to `diff` command to do a compare against file2

> example 3-4 backup of all files changed in last day
```bash
#!/bin/bash
# backs up all files in current directory modified within in last 24 hours
# in a tarball (tarred and gizpped file).

BACKUPFILE=backup-$(date +%m-$d-%Y)
# embeds date in backup filename
archieve=${1:-$BACKUPFILE}
# if no backup-archive filename specified on command-line,
# it will default to 'backup-MM-DD-YYYY.tar.gz."

tar cvf - `find . -mtime -l -type f -print ` > $archive.tar
gzip $archive.tar
echo "directory $PWD backed up in archive file \"$archive.tar.gz\"."


# stephane chazelas points out that the above code will fail
# if there are too man files found 
# or if any filename contain blank characters.
# following alternatives
# ---------------------------------------------------------------
# find . mtime -l -type f -print0 | xargs -0 tar rvf "$archive.tar"
# using the GUN version of find 

# find . -mtime -l -type f -exec tar rvf "$archive.tar" '{}' \;
# portable to other unix flavors, but much slower.

exit 0
```
filename beginning with '-' may cause problems when coupled with the '-' redirection operator. a script should check for this and add an appropriate prefix to such filenames. for example ./-FILENAME, $PWD/-

FILENAME, OR $PATHNAME/-FILENAME

if the value of a variable begins with a `-`, this may likewise create problems
```bash
var='-n'
echo $var
# has the effect of "echo -n", and outputs nothing
```

## `-` previous working directory. a cd - command changes to the previous working directory tis 
do not confuse the '-' used in this sense with the '-' redirection operator just discussed. the interpretation of the '-' depends on the context int which it appears.

## `-` Minus

## `=` Equals
assignment operator

## `+` Plus
addition arithmetic operator

## `+` option
option flag for a command or filter, certain commands and builtins
uses the + to enable certain options and the - to disable them. 
in parameter substitution, the + prefixes an alternate value that a variable expands to

## `%` modulo
modulo remainder of a division, arithmetic operation
```bash
let "z=5%3"
echo $z # 2
```
in a different context, the % is a pattern matching operator

## `~` home directory [tilde]
the corresponds to the $HOME internal variable. -bozo is bozo's home directory, and `ls ~bozo` list the contents of it. `~/` is the current user's home directory, and `ls ~` lists the contents of it.


## `~+` current working directory
this corresponds to the $PWD internal variable

## `~-` previous working directory. 
this corresponds to the $OLDPWD internal variable

## `=~` regular expression match. 
this operator was introduced with version 3 of bash

## `^, ^^` Uppercase conversion in parameter substitution 
(added in version 4 of bash)

---
# Control Characters
change the behavior of the terminal or text display. a control character is a control + key combination. a control character may also be written in octal or hexadecimal notation. following an escape
>Control characters are not normally useful inside a script

## `Ctl-A`
Moves cursor to beginning of the line of text

## `Ctl-B`
backspace(nonedestructive)

## `Ctl-C`
break. terminate a foreground job

## `Ctl-D`
log out from a shell similar to exit
**EOF** (end-of-file). this also terminates input from stdin
when typing text on the console or in an xterm window. Ctl-D erases the character under the cursor when there are no characters present, Ctl-D logs out of the session. as expected. in an xterm window, this has the effect of closing the window.

## `Ctl-E`
Move cursor to end of line of text( on the command-line)

## `Ctl-F` 
move to next character (command-line)

## `Ctl-G` ring a BEL

## `Ctl-H`
Rubout (destructive backspace) erases characters the cursor back over while backspacing
```bash
#!/bin/bash
# embedding Ctl-H in a string
a="^H^H"  # two Ctl-H's -- backspaces
          # Ctl-V Ctl-H, using vi;/vmi

echo "abcdef"
echo
echo -n "abcdef$a " # abcd f 
# space at the   ^        ^  backspace twice
echo
echo -n "abcdef$a"  # abcdef
# no space at the end,      ^ doesn't backspace (why?)
echo; echo

# a=$'\010\010'
# a=$'\b\b'
# a=$'\x08\x08'
# but this does not change the results

# now, try this
rubout="^H^H^H^H^H"   # 5 x Ctl-H
echo -n "12345678"
sleep 2
echo -n "$rubout"
sleep2
```

## `Ctl-I` Horizontal tab


## `Ctl-J` Newline (line feed)
in a script, may also be expressed in octal notation --'\012' or in hexadecimal --'\x0a'


## `Ctl-K` Vertical tab
when typing text on the console or in an xterm window, Ctl-k erases from the characters under the cursor to end of line. within a script, Ctl-K may behave differently.

## `Ctl-L` Carriage return

## `Ctl-N` Erases a line of text recalled from history buffer

## `Ctl-O` issues a newline

## `Ctl-P` Recalls last command from history buffer


## `Ctl-Q` resume (XON)
this resumes stdin in a terminal

## `Ctl-R`
backwards search for text in history buffer (command-line)

## `Ctl-S` Suspend (xOFF)
this freezes stdin in a terminal. use Ctl-Q to restore input

## `Ctl-T` erase a line of input, from the cursor backward to beginning of line.
in some settings, Ctl-U erases t he entire line of input, regardless of cursor position

## `Ctl-V` 
when inputting text, Ctl-V permits inserting control characters. 

## `Ctl-W` 
when typing text on hte console or in xterm window, Ctol-w erases formt eh character under the cursor backwards to the first instance of whitespace. in some settings, Ctl-W erases backwards to first non-alphanumeric character.

## `Ctl-X`
in certain word processing programs, cuts highlighted text and copies to clipboard

## `Ctl-Y`
pastes back text

## `Ctl-Z`
pauses a foreground job, substitute operation in certain word processing applicatons


## Whitespace
functions as a separator between commands and /or variables

