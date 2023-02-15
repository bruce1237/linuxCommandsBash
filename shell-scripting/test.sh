command_test () { type "$1" &>/dev/null; }

cmd=rmdir # legitimate command
command_test $cmd; echo $? # 0

cmd=bogus_command # illegitimate command
command_test $cmd; echo $? # 1