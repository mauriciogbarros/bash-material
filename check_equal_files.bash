#!/bin/bash

# Script to check whether two given files are
# identical
# 1) Check whether the user provided the correct
# number of arguments.
# 2) Check whether both are files and exist.
# 3) Calculate the size of each file and compare.

if [ $# -eq 2 ]
then
  if [ -f ./$1 ] && [ -f ./$2 ]
  then
    size1=($(wc -c $1))
    size2=($(wc -c $2))
    if [ $size1 -eq $size2 ]
    then
      echo "Files are similar"
    else
      echo "Files are different"
    fi
  else
    echo "The provided file(s) do not exist."
  fi
else
  echo "Incorrect number of files provided"
fi
