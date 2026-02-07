#!/bin/bash


VERSION="0.1.0"
SCRIPT_NAME="autoupdate"

show_commands(){
	echo "Testing"
}

while [[ "$#" -gt 0 ]]; do
	case $1 in 
		-v|--version )
			echo "$SCRIPT_NAME version: $VERSION"
			exit 0
			;;
		-h|--help)
			show_commands
			exit 0
			;;
		--check-update)
			ver=$(curl -s https://raw.githubusercontent.com/ritwik-pandey/repo-sync/main/version.txt)
			if [[ "$(printf '%s\n' "$VERSION" "$ver" | sort -V | tail -n1)" != "$VERSION" ]]; then
    				echo "Update available!"
			else
    				echo "Already on latest version"
			fi
			exit 0
			;;
		--self-update)
			Script_path="$(realpath "$0")"
			Script_url="https://raw.githubusercontent.com/ritwik-pandey/repo-sync/main/autoupdate.sh"
			curl -fsSL "$Script_url" -o /tmp/autoupdate.new
			[ -s /tmp/autoupdate.new ] || {
				echo "download failed"
				exit 1
			}
			cp -p "$Script_path" "$Script_path.bak"
			chmod +x /tmp/autoupdate.new
			mv /tmp/autoupdate.new "$Script_path"
			if "$Script_path" --version > /dev/null 2>&1; then
				echo "Updated Successfully"
				rm -f "$Script_path.bak"
				exit 0
			fi
			echo "Failed. Rolling back"
			mv "$Script_path.bak" "$Script_path"
			echo "Previous version installed."
			exit 0
			;;
		*)
			shift
			;;
	esac
	shift
done






