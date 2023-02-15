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
