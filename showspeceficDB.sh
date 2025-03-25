#!/bin/bash

function SpecificDB {
    clear
    echo "=========================================="
    echo "🔍       SEARCH FOR A DATABASE       🔍"
    echo "=========================================="

    while true; do
        read -p "🔹 Enter the database name or type 'exit' to return: " user_input

        if [[ "$user_input" == "exit" ]]; then
            dbMainMenu
        elif [[ -z "$user_input" || "$user_input" == *" "* ]]; then
            echo -e "${RED}❌ Error: Database name cannot be empty or contain spaces.${NC}"
        elif [[ "$user_input" == *['!''?'@\#\$%^\&*()'-'+\.\/';']* ]]; then
            echo -e "${RED}❌ Error: Database name cannot contain special characters.${NC}"
        elif [[ -d "$DB_MAIN_DIR/$user_input" ]]; then
            echo "------------------------------------------"
            echo "📂 Contents of '$user_input':"
            ls -1 "$DB_MAIN_DIR/$user_input"
            echo "------------------------------------------"
        else
            echo -e "${RED}❌ Error: The database '$user_input' was not found.${NC}"
        fi
    done
}

