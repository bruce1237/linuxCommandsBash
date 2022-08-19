sed
sed is for stream editor, allows to edit modify text. it often used with text files to change things inside text files.


	sample file: src/toppings.txt
	------------------------------
	Pizza topping combos:
	1. Spinach, Pepperoin, Pineapple
	2. Pepperoni, Pineapple, Mushrooms
	3. Bacon, Banana Peppers, Pineapple
	4. Cheese, Pineapple


string replacement, this will not modify the orignal file, only output the replaced content

CMD:	sed 's/TargetString/ReplaceToString' sourceFileName
	e.g.: sed 's/Pineapple/Feta/' src/toppings.txt // replace pineaple to Feta
	/: is the delimiter to indicate the parts, can be space( ), pipe (|), dot(.) etc...
		if the delimiter has confilict with the string wants to replace, just change the delimiter


	

	output: 
	-------------------------------
	Pizza topping combos:
	1. Spinach, Pepperoin, Feta
	2. Pepperoni, Feta, Mushrooms
	3. Bacon, Banana Peppers, Feta
	4. Cheese, Feta

string replace the original file:
CMD:    sed -i 's/TargetString/ReplaceToString' sourceFileName
	-i: replace the string inside file 




