#!/bin/bash
# ex1.sh

# This is an exercise of VE280 Lab 1, SU2020.
# Written by Martin Ma.
# Latest Update: 5/10/2020.
# Copyright © 2020 Mars-tin. All rights reserved.

# Stop on errors.
# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/.
set -Eeuo pipefail


usage() {
	# Command line options.
	# Do not modify this function.
	echo "Usage: $0 <create | dump | list | display | destroy>"
	echo "---------------------------------------------------------------"
	echo "> create   |   create the database and webserver"
	echo "> dump     |   dump data into the webserver"
	echo "> list     |   list webserver files"
	echo "> display  |   display data in the webserver"
	echo "> destroy  |   remove the database and webserver"
	echo "---------------------------------------------------------------"
	echo "example: $ ./ex1.sh create"
	echo "will run the 'create' function you wrote."
	echo "---------------------------------------------------------------"
	exit 2
}


create() {
	# If a database already exists, raise an error.
    	if [ -f sql/database.txt ]; then
        	exist_error
    	fi
		
	# Create a directory named `webserver/`.
	mkdir -p webserver

	# Create a directory named `sql/`.
	# TODO: Replace this line with a linux command line.

	# Create and initialize the database.
	echo "Hello World!" > sql/database.txt
}


dump() {
	# Copy the file `sql/database.txt` to the directory `webserver/`
	# TODO: Replace this line with a linux command line.
}


list() {
	# List all files in directory `webserver/`.
	# TODO: Replace this line with a linux command line.
}


display() {
	# Display `webserver/database.txt` in stdout.
	# TODO: Replace this line with a linux command line.
}


destroy() {
	# Remove the `webserver/` and `sql/` directories.
	# TODO: Replace this line with a linux command line.
}


no_case() {
	# Raise testcase existence error.
	# Do not modify this function.
	echo "Error: there is no such case"
	exit 1
}

alert() {
	# Raise database existence error.
	# Do not modify this function.
	echo "Hint: your implementation is wrong"
	exit 1
}


exist_error() {
	# Raise database existence error.
	# Do not modify this function.
	echo "Error: database already exists"
	exit 1
}

###############################################
#################### Main #####################
###############################################
#                                             #
# !!!!! Do not modify the scripts below !!!!! #
#                                             #
###############################################


# Sanity check. 
# If argument number != 2, raise an error.
if [ $# -ne 2 ] && [ $# -ne 1 ]; then
	usage
fi

if [ $# -ne 1 ]; then
	# Clean up.
	if [ -d webserver/ ]; then
		rm -r webserver/
	fi

	if [ -d sql/ ]; then
		rm -r sql/
	fi
fi

# Parse argument.
# $X means the Xth argument
case $1 in
	"create")
		if [ $# -ne 2 ]; then
			create
			if [ $? -ne 0 ]; then
				alert
			fi
		fi

		if [ $# -ne 1 ]; then
			case $2 in
				"1")
					create
					if [ $? -ne 0 ]; then
						echo "1"
					fi
					if [ ! -f sql/database.txt ]; then
						echo "1"
					fi
					echo "0"
					;;
				*)
					no_case
					;;
			esac
		fi
		;;

	"dump")
		if [ $# -ne 2 ]; then
			dump
			if [ $? -ne 0 ]; then
				alert
			fi
		fi

		if [ $# -ne 1 ]; then
			case $2 in
				"1")
					mkdir -p webserver
					mkdir -p sql
					echo "This is the home page." > sql/database.txt
					dump
					if [ $? -ne 0 ]; then
						echo "1"
					fi
					if [ ! -f webserver/database.txt ]; then
						echo "1"
					fi
					out=$(cat webserver/database.txt)
					if [ $? -ne 0 ]; then
						echo "1"
					fi
					if [ ! "$out" == "This is the home page." ]; then
						echo "1"
					fi
					echo "0"
					;;
				"2")
					create
					if [ $? -ne 0 ]; then
						echo "1"
					fi
					dump
					if [ $? -ne 0 ]; then
						echo "1"
					fi
					if [ ! -f webserver/database.txt ]; then
						echo "1"
					fi
					out=$(cat webserver/database.txt)
					if [ $? -ne 0 ]; then
						echo "1"
					fi
					if [ ! "$out" == "Hello World!" ]; then
						echo "1"
					fi
					echo "0"
					;;
				*)
					no_case
					;;
			esac
		fi
		;;

	"list")
		if [ $# -ne 2 ]; then
			list
			if [ $? -ne 0 ]; then
				alert
			fi
		fi

		if [ $# -ne 1 ]; then
			case $2 in
				"1")
					mkdir -p webserver
					mkdir -p sql
					echo "I don't want to design labs again :( it's so tiring!" > sql/test.txt
					cp sql/test.txt webserver
					out=$(list)
					if [ $? -ne 0 ]; then
						echo "1"
					fi
					if [ ! "$out" == "test.txt" ]; then
						echo "1"
					fi
					echo "0"
					;;
				"2")
					mkdir -p webserver
					mkdir -p sql
					echo "I don't want to design labs again :( it's so tiring!" > sql/test1.txt
					echo "I don't want to design labs again :( it's so tiring!" > sql/test2.txt
					echo "I don't want to design labs again :( it's so tiring!" > sql/test3.txt
					cp sql/test*.txt webserver
					out=$(list)
					if [ $? -ne 0 ]; then
						echo "1"
					fi
					ans=$(ls webserver)
					if [ ! "$out" == "$ans" ]; then
						echo "2"
					fi
					echo "0"
					;;
				"3")
					create
					if [ $? -ne 0 ]; then
						echo "1"
					fi
					dump
					if [ $? -ne 0 ]; then
						echo "1"
					fi
					out=$(list)
					if [ $? -ne 0 ]; then
						echo "1"
					fi
					if [ ! "$out" == "database.txt" ]; then
						echo "1"
					fi
					echo "0"
					;;
				*)
					no_case
					;;
			esac
		fi
		;;

	"display")
		if [ $# -ne 2 ]; then
			display
			if [ $? -ne 0 ]; then
				alert
			fi
		fi

		if [ $# -ne 1 ]; then
			case $2 in
				"1")
					mkdir -p webserver
					mkdir -p sql
					echo "I don't want to design labs again :( it's so tiring!" > sql/database.txt
					cp sql/database.txt webserver
					out=$(display)
					if [ $? -ne 0 ]; then
						echo "1"
					fi
					if [ ! "$out" == "I don't want to design labs again :( it's so tiring!" ]; then
						echo "1"
					fi
					echo "0"
					;;
				"2")
					create
					if [ $? -ne 0 ]; then
						echo "1"
					fi
					dump
					if [ $? -ne 0 ]; then
						echo "1"
					fi
					out=$(display)
					if [ $? -ne 0 ]; then
						echo "1"
					fi
					if [ ! "$out" == "Hello World!" ]; then
						echo "1"
					fi
					echo "0"
					;;
				*)
					no_case
					;;
			esac
		fi
		;;

	"destroy")
		if [ $# -ne 2 ]; then
			destroy
			if [ $? -ne 0 ]; then
				alert
			fi
		fi

		if [ $# -ne 1 ]; then
			case $2 in
				"1")
					mkdir -p webserver
					mkdir -p sql
					echo "qwqwq" > sql/test.txt
					cp sql/test.txt webserver
					destroy
					if [ $? -ne 0 ]; then
						echo "1"
					fi
					if [ -f sql/test.txt ]; then
						echo "1"
					fi
					if [ -f webserver/test.txt ]; then
						echo "1"
					fi
					if [ -d webserver/ ]; then
						echo "1"
					fi
					if [ -d sql/ ]; then
						echo "1"
					fi
					echo "0"
					;;
				"2")
					create
					if [ $? -ne 0 ]; then
						echo "1"
					fi
					dump
					if [ $? -ne 0 ]; then
						echo "1"
					fi
					destroy
					if [ $? -ne 0 ]; then
						echo "1"
					fi
					if [ $? -ne 0 ]; then
						echo "1"
					fi
					if [ -f sql/test.txt ]; then
						echo "1"
					fi
					if [ -f webserver/test.txt ]; then
						echo "1"
					fi
					if [ -d webserver/ ]; then
						echo "1"
					fi
					if [ -d sql/ ]; then
						echo "1"
					fi
					echo "0"
					;;
				*)
					no_case
					;;
			esac
		fi
		;;

	*)
		usage
		;;

esac

# Clean up.
if [ $# -ne 1 ]; then
	if [ -d webserver/ ]; then
		rm -r webserver/
	fi

	if [ -d sql/ ]; then
		rm -r sql/
	fi
fi

