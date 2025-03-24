#!/bin/bash

function SpecificDB {
    clear
    echo "********************************"
    echo "    Show a Specific Database :)"
    echo "********************************"

    while true; do
        read -p "Enter the database name or type 'exit' to return: " user_input
        if [[ $user_input == "exit" ]]; then
            dbMainMenu
        fi
        if [[ -z $user_input || $user_input == *" "* ]]; then
            echo "❌ Error: Database name cannot be empty or contain spaces."
            
        fi
        if [[ $user_input == *['!''?'@\#\$%^\&*()'-'+\.\/';']* ]]; then
            echo "❌ Error: Database name cannot contain special characters."
            
        fi

        if [[ -d "$DB_MAIN_DIR/$user_input" ]]; then
            echo "📂 Contents of '$user_input':"
            ls -1 "$DB_MAIN_DIR/$user_input"
            echo "********************************"
            
        else
            echo "❌ Error: The database '$user_input' was not found."
        fi
    done
}

