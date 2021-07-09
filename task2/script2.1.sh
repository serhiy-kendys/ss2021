#!/bin/bash
MYSQL_PASSWORD="*******"
DATE=$(date +\%Y\%m\%d_\%H\%M)
DB=moodle_test
echo "Task 2.1"
echo "----------------------------------------"
if [ $# -eq 0 ]
  then
    echo "Please use script with argument: $0 </path/directory>"
    exit 1
fi

if [ -d "$1" ]
  then
    touch $1/test_file > /dev/null 2>&1
    if [ $? -eq 0 ]
      then
	rm $1/test_file
      else
	echo "You don't have permissions to write in $1"
	exit 1
    fi
  else
    echo "Directory $1 not found"
    exit 1
fi

if [ `pgrep mysql | wc -l` -le 1 ]
  then
    mysqldump -u moodle -p$MYSQL_PASSWORD moodle_test | gzip -9 > "$1/moodle_test-$DATE.sql.gz"
    if [ $? -eq 0 ]
      then
	echo "Backup completed successfully"
	exit 0
      else
	echo "Some errors occurred during backup creation"
	exit 1
    fi
  else
    echo "Service mysql don't running"
    exit 1
fi
