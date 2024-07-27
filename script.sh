#! /usr/bin/bash

filename="index.html"

if test $filename
then
	echo "File $filename already exists! Please enter a new filename"
	echo "To overwrite the file, re-type the filename"
	read filename
fi

echo "Please give URL of the ocw.acs.upb.ro homework you wish to be downloaded"
read hw_link

curl $hw_link > $filename 2> /dev/null

aux1=$(grep -n '<div class="left_page"' $filename)
aux1=$(echo $aux1 | cut -d ':' -f 1)
aux2=$(grep -n '<div class="dokuwiki"' $filename)
aux2=$(echo $aux2 | cut -d ':' -f 1)
aux2=$(echo $aux2 + 1 | bc)
aux1=$(echo $aux1 - 1 | bc)
sed -i $(echo -n $aux2,$aux1)d $filename


aux2=$(grep -n 'div class="right_sidebar"' $filename)
aux2=$(echo $aux2 | cut -d ':' -f 1)
aux1=$(wc -l $filename)
aux1=$(echo $aux1 | cut -d ' ' -f 1)
sed -i $(echo -n $aux2,$aux1)d $filename
echo "</div></div></body></html>" >> $filename
sed -i 's/"\/courses/"https:\/\/ocw.cs.pub.ro\/courses/g' $filename
