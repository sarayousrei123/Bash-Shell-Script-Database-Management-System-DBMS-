#!/bin/bash
function renameDB {
  	clear
        echo "*************************************"
	echo "can renameDB here :)"
	echo "*************************************"
    echo -n "Enter the current database name: "
    read old_name

    old_path="$DB_MAIN_DIR/$old_name"

    if [[ ! -d "$old_path" ]]; then
        echo -e "\e[31mDatabase '$old_name' does not exist!\e[0m"
        return
    fi

    echo -n "Enter the new database name: "
    read new_name

    new_path="$DB_MAIN_DIR/$new_name"

    if [[ -d "$new_path" ]]; then
        echo -e "\e[31mDatabase '$new_name' already exists!\e[0m"
        return
    fi
     if [[ -z $new_name || $new_path == *" "* ]]; then
            echo "❌ Error: Database name cannot be empty or contain spaces."
            return
        fi
        if [[ $new_name == *['!''?'@\#\$%^\&*()'-'+\.\/';']* ]]; then
            echo "❌ Error: Database name cannot contain special characters."
            return
        fi

    mv "$old_path" "$new_path"
    echo -e "\e[32mDatabase renamed successfully from '$old_name' to '$new_name'!\e[0m"
} 
