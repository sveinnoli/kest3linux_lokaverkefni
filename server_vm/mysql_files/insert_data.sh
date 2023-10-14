#!/bin/bash
export DEBIAN_FRONTEND=noninteractive # prevent dumbass commands from being interactive

# Check if the correct number of arguments is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <csv_file>"
    exit 1
fi

# Set csv_file to filepath provided
csv_file="$1"

# Read CSV data line by line
while IFS=',' read -r name firstname lastname usrname email department id; do
    if [ -n "$name" ] && [ -n "$firstname" ] && [ -n "$lastname" ] && [ -n "$usrname" ] && [ -n "$email" ] && [ -n "$department" ] && [ -n "$id" ]; then
	    sudo mysql -D HumanResources -uroot -e "INSERT INTO Employees(employeeID, firstname, lastname, salary) values('$id', '$firstname', '$lastname', 1000000);"
            
            result=$(sudo mysql -D HumanResources -uroot -se "SELECT COUNT(*) from Departments where department_name='$department'")

	    if [ "$result" -eq 0 ]; then
                 sudo mysql -D HumanResources -uroot -e "INSERT INTO Departments(department_name) values('$department')"
            fi
    fi
done < <(tail -n +2 "$csv_file")

