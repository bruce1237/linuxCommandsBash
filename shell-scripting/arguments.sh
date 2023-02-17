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
