 veg1=xyz
 veg2=a

 if [[ "$veg1" < "$veg2" ]]
 then
    echo "Although $veg1 precede $veg2 in the dictionary,"
    echo -n "this does not necessarily imply anything "
    echo "about my culinary preferences."
else
    echo "what kind of dictionary are you using, anyhow?"
fi
