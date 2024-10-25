#!/bin/bash

echo "Step 2: Formulate a command which displays record 9 ~ 12"
sed -n '9,12 p' dataset.txt
echo -e '\n'

echo "Step 3: Formulate a command which sorts data based on \"job\""
sort -t, -k3 dataset.txt
echo -e '\n'

echo "Step 4: Formulate a command which displays all departments."
echo "Transform them into upper case."
echo "Store the output into a new file, named \"output.txt\""
awk -F, '{print $5}' dataset.txt \
	| sort -u \
	| tr '[a-z]' '[A-Z]' \
	> output.txt
echo -e '\n'

echo "Step 5: Formulate a comman which display the number of"
echo "characters of last record/line of the given data"
tail -n 1 dataset.txt | wc -c
echo -e '\n'

echo "Step 6: Formulate a command which displays company_name and"
echo "job that their year is between 2007~2012"
awk -F, '$4 >= 2007 && $4 <= 2012 {print $2, $3}' dataset.txt
