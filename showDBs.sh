#!/bin/bash

function showDBs { 
   clear
    echo "***********************************"
    echo "       Available Databases :)"
    echo "***********************************"

    while true; do
        read -p "Enter 'show all' to list all databases, 'showspecificDB' to search for a specific one, or 'exit' to return: " choose

        if [[ $choose == 'exit' ]]; then
            dbMainMenu
        elif [[ $choose == 'show all' ]]; then
            # Check if databases exist
            if [[ ! -d "$DB_MAIN_DIR" || -z $(find "$DB_MAIN_DIR" -mindepth 1 -type d 2>/dev/null) ]]; then
                echo "❌ Sorry, no databases found!"
                echo "***********************************"
            else
                echo "📂 Databases:"
                ls -1 "$DB_MAIN_DIR"  # List database names
                echo "***********************************"
            fi
        elif [[ $choose == 'showspecificDB' ]]; then
            SpecificDB
        else 
            echo "❌ Invalid option!"
        fi
    done
}

