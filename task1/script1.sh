#!/bin/bash
echo "Task 1"
echo "----------------------------------------"
if [ "$1" = "" ] || [ "$2" = "" ]
  then
    echo "Please use script with two arguments: $0 user /path/directory."
  else
    result=$(id $1 2>&1 > /dev/null)
    if [ $? -eq 0 ]
      then
        if [ -d "$2" ]
          then
            chown -R $1 $2
            if [ $? -eq 0 ]
              then
                echo "Success"
              fi
          else
            echo "Directory $2 does not exists or you don't have permission to access it."
        fi
      else
        echo $result
    fi
fi
