#!/bin/bash

# Assignment 2 - Task #1
# Course:           UNX510
# Family Name:      Gomes de Barros
# Given Name:       Mauricio
# Student Number:   122-509-227
# Login name:       mgomes-de-barros
# Due Date:         APR 07, 2024
#
# I declare that the attached assignment is my own work in
# accordance with Seneca Academic Policy. No part of this
# assignment has been copied manually or electronically from
# any other source (including web sites) or distributed to
# other students.

if (( $# < 2 ))
then
  if [ "$#" -eq 0 ] || [[ -e "$1" && -d "$1" ]]
  then
    quitFlag=0
    # Get the path of $1
    path=$(realpath $1)

    # Get the number of filenames in the path: numFilenames
    numFilenames=$( echo $path | awk -F"/" '{print NF}' )

    # Arrays
    # Initialization: index 0
    filenames[0]="/"
    owner_p[0]=$( ls -ld ${filenames[0]} | cut -c 2-4 )
    group_p[0]=$( ls -ld ${filenames[0]} | cut -c 5-7 )
    other_p[0]=$( ls -ld ${filenames[0]} | cut -c 8-10 )
    links[0]=$( ls -ld ${filenames[0]} | awk -F" " '{print $2}' )
    owners[0]=$( ls -ld ${filenames[0]} | awk -F" " '{print $3}' )
    groups[0]=$( ls -ld ${filenames[0]} | awk -F" " '{print $4}' )
    sizes[0]=$( ls -ld ${filenames[0]} | awk -F" " '{print $5}' )
    modifiedDates[0]=$( ls -ldT ${filenames[0]} | awk -F" " '{print " " $6,$7,$9}' )
    
    # Update the currentPath that will be used to populate the arrays
    currentPath=${filenames[0]}

    # Populate arrays
    for (( n=2 ; n<=$numFilenames ; n++ ))
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
      modifiedDates[n-1]=$( ls -ldT $currentPath | awk -F" " '{print " " $6,$7,$9}' )
      currentPath+="/"
    done

    # Cursor parameters
    cursorCol=24
    minCursorRow=4
    maxCursorRow=$((2*numFilenames+minCursorRow))
    cursorRow=$maxCursorRow

    while [ "$quitFlag" != 1 ]
    do
      clear

      # Output to the screen
      echo "Owner   Group   Other   Filename"
      echo "-----   -----   -----   --------"
      echo
      currentRow=$minCursorRow
      
      # Iterate the output for each respective item in the arrays
      for (( n=0 ; n<=numFilenames ; n++))
      do
        echo -n ${owner_p[n]} | awk '$1=$1' FS= OFS=" " ORS=
        echo -n "   "
        echo -n ${group_p[n]} | awk '$1=$1' FS= OFS=" " ORS=
        echo -n "   "
        echo -n ${other_p[n]} | awk '$1=$1' FS= OFS=" " ORS=
        echo -n "   "
        echo ${filenames[n]}
        if [[ currentRow -eq cursorRow ]]
        then
          echo -n "   Links: ${links[n]}"
          echo -n "   Owner: ${owners[n]}"
          echo -n "   Group: ${groups[n]}"
          echo "   Size: ${sizes[n]}"
          echo "Modified: ${modifiedDates[n]}"
        fi
        currentRow=$((currentRow+2))
      done
      echo
      echo
      echo
      echo "Valid commands: u(p)   d(own)   q(uit)"
      read -n1 command
      case $command in
        u)
          if ((cursorRow > minCursorRow))
          then
            cursorRow=$((cursorRow-2))          
          fi
          ;;
        d)
          if ((cursorRow < maxCursorRow))
          then
            cursorRow=$((cursorRow+2))
          fi
          ;;
        q)
          quitFlag=1
          ;;
      esac
    done
    echo
    exit 0
  else
    echo "$1 is not a valid directory name" >&2
    exit 1
  fi

else
  echo "Usage: pathdisplay [ dir-name ]" >&2
  exit 1
fi
