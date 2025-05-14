#!/bin/bash

# Script to create a directory, with error handling

# 1. Identify Potential Errors:
#    - Directory already exists
#    - User lacks permissions to create the directory
#    - Invalid directory name

# 2. Use Conditional Statements:
#    - Check if the directory exists before creating it.
#    - Check the exit status of the `mkdir` command.

# 3. Provide Informative Messages:
#    - If the directory exists, tell the user.
#    - If there's a permission error, inform the user and suggest a solution.
#    - If the directory name is invalid, provide guidance.

# Define the directory name
dir_name="my_directory"

# Check if the directory already exists
if [ -d "$dir_name" ]; then
  echo "Error: Directory '$dir_name' already exists."
  echo "Please choose a different name or delete the existing directory."
  exit 1
fi

# Attempt to create the directory
mkdir "$dir_name"
if [ $? -ne 0 ]; then
  # The `mkdir` command failed.  $? holds the exit status.
  echo "Error: Failed to create directory '$dir_name'."
  # Check for common errors and provide specific advice.
  if [ ! -w "$(dirname "$dir_name")" ]; then
    echo "Possible cause: You do not have write permissions in the parent directory."
    echo "Solution: Use 'chmod +w' on the parent directory, or run the script with 'sudo'."
  elif [ ! "$dir_name" ]; then #check if the directory name is empty
    echo "Possible cause: The directory name is empty."
    echo "Solution: Provide a valid directory name."
  else
    echo "Solution: Check the error message above and try again."
  fi
  exit 1
fi

# If we get here, the directory was created successfully.
echo "Directory '$dir_name' created successfully."
exit 0

