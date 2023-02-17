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
sleep 2
