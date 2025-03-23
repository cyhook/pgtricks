#!/bin/bash

# Directories to compare
DIR1="$1"
DIR2="$2"

# Check if both directories are provided
if [ -z "$DIR1" ] || [ -z "$DIR2" ]; then
  echo "Usage: $0 <dir1> <dir2>"
  exit 1
fi

# Check if both directories exist
if [ ! -d "$DIR1" ]; then
  echo "Directory $DIR1 does not exist."
  exit 1
fi

if [ ! -d "$DIR2" ]; then
  echo "Directory $DIR2 does not exist."
  exit 1
fi

# Loop through files in the first directory
for FILE1 in "$DIR1"/*; do
  # Check if it's a file
  if [ -f "$FILE1" ]; then
    # Get the base name of the file
    BASENAME=$(basename "$FILE1")
    
    # Check if the file exists in the second directory
    FILE2="$DIR2/$BASENAME"
    if [ -f "$FILE2" ]; then
      # Compare the files using diff
      echo "Comparing $BASENAME:"
      diff "$FILE1" "$FILE2" > /dev/null
      if [ $? -eq 0 ]; then
        echo "Files are identical."
      else
        echo "Files differ."
      fi
    else
      echo "File $BASENAME does not exist in $DIR2."
    fi
  fi
done
