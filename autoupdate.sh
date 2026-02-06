#!/bin/bash


VERSION="0.1.0"
SCRIPT_NAME="scraper-cli"

show_commands(){
	echo "Testing"
}

while [[ "$1" != " " ]]; do
	case $1 in 
		-v|--version )
			echo "$SCRIPT_NAME version: $VERSION"
			exit 0
			;;
		-h|--help)
			show_commands
			exit 0
			;;
		*)
			shift
			;;
	esac
	shift
done



