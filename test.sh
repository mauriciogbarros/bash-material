#!/bin/bash

path=$(realpath $1)
echo $path
echo
numFilenames=$( echo $path | awk -F"/" '{print NF}' )
echo $numFilenames
echo

filenames[0]="/"
owner_p[0]=$( ls -ld ${filenames[0]} | cut -c 2-4 )
group_p[0]=$( ls -ld ${filenames[0]} | cut -c 5-7 )
other_p[0]=$( ls -ld ${filenames[0]} | cut -c 8-10 )
links[0]=$( ls -ld ${filenames[0]} | awk -F" " '{print $2}' )
owners[0]=$( ls -ld ${filenames[0]} | awk -F" " '{print $3}' )
groups[0]=$( ls -ld ${filenames[0]} | awk -F" " '{print $4}' )
sizes[0]=$( ls -ld ${filenames[0]} | awk -F" " '{print $5}' )
modifiedDates[0]=$( ls -ldT ${filenames[0]} | awk -F" " '{print " " $6,$7,$9}' )

currentPath=${filenames[0]}
echo $currentPath

for (( n=1 ; n<=$numFilenames ; n++ ))
do
  filenames[n]+=$( echo $path | awk -F"/" -v n=$n '{print $n}' )
  currentPath+=${filenames[n]}
  owner_p[n]=$( ls -ld $currentPath | cut -c 2-4 )
  group_p[n]=$( ls -ld $currentPath | cut -c 5-7 )
  other_p[n]=$( ls -ld $currentPath | cut -c 8-10 )
  links[n]=$( ls -ld $currentPath | awk -F" " '{print $2}' )
  owners[n]=$( ls -ld $currentPath | awk -F" " '{print $3}' )
  groups[n]=$( ls -ld $currentPath | awk -F" " '{print $4}' )
  sizes[n]=$( ls -ld $currentPath | awk -F" " '{print $5}' )
  modifiedDates[n]=$( ls -ldT $currentPath | awk -F" " '{print " " $6,$7,$9}' )
  currentPath+="/"
done

echo "Filenames"
echo ${filenames[@]}
echo "Owner permissions"
echo ${owner_p[@]}
echo "Group permissions"
echo ${group_p[@]}
echo "Other permissions"
echo ${other_p[@]}
echo "Links"
echo ${links[@]}
echo "Owners"
echo ${owners[@]}
echo "Groups"
echo ${groups[@]}
echo "Sizes"
echo ${sizes[@]}
echo "Modified Dates"
echo ${modifiedDates[@]}

# owner_p[0]=$( ls -ld ${filenames[0]} | cut -c 2-4 )
# group_p[0]=$( ls -ld ${filenames[0]} | cut -c 5-7 )
# other_p[0]=$( ls -ld ${filenames[0]} | cut -c 8-10 )
# links[0]=$( ls -ld ${filenames[0]} | awk -F" " '{print $2}' )
# owners[0]=$( ls -ld ${filenames[0]} | awk -F" " '{print $3}' )
# groups[0]=$( ls -ld ${filenames[0]} | awk -F" " '{print $4}' )
# sizes[0]=$( ls -ld ${filenames[0]} | awk -F" " '{print $5}' )
# modifieds[0]=$( ls -ldT ${filenames[0]} | awk -F" " '{print " " $6,$7,$9}' )
# echo "onwer permissions: ${owner_p[0]}"
# echo "group permissions: ${group_p[0]}"
# echo "other permissions: ${other_p[0]}"
# echo "links: ${links[0]}"
# echo "owner: ${owners[0]}"
# echo "group: ${groups[0]}"
# echo "size: ${sizes[0]}"
# echo "modified:${modifieds[0]}"



# for filename in "${filenames[@]}"
# do
#   echo "$filename"
# done

# for (( n=1 ; n<=$numDirs ; n++ ))
# do
#   dirs+=$n
# done

# for n in ${dirs[@]}
# do
#   echo $n
# done

# for (( n=2 ; n<$numFilenames ; n++ ))
# do
#   filenames+=$( awk -F"/" -v n="$n" '{print $n}' <<< $path)
# done