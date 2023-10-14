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
        sudo groupadd "$department" 2> /dev/null
	
    	sudo useradd -g "$department"\
		-m\
		-d "/home/$usrname"\
		-u $id\
		-s "/bin/bash"\
		-p "$(echo "secretpassword112" | openssl passwd -1 -stdin)" "$usrname"
    fi
done < <(tail -n +2 "$csv_file")

