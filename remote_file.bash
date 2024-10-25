#!/bin/bash

# Open a file from a remote machine and identify its permission.
# The file is named "credential.txt" and 
# is located under [user name]/myData/
# Display the permission setting of the "credential.txt"


fileName="credential.txt"
filePath='/Users/'$USER'/myData/'

ls -l $filePath$fileName
