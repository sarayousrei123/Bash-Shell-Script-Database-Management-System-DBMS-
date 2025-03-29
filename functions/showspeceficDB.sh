#!/bin/bash

function SpecificDB {
    clear
    echo "=========================================="
    echo "  🔍   SEARCH FOR A DATABASE      🔍"
    echo "=========================================="

    while true; do
        read -p "🔹 Enter the database name or type  'exit' to return: " dbname
        validateDBName "$dbname"
        if [[ $? -ne 0 ]]; 
        then
            continue
        fi


        if [[ "$dbname" == "exit" ]]; then
            dbMainMenu
        elif [[ -d "$DB_MAIN_DIR/$dbname" ]]; then
            echo "------------------------------------------"
            echo "📂 Contents of '$dbname':"
            ls -1 "$DB_MAIN_DIR/$dbname"| awk '{print "📄 " $0}'  
            echo "------------------------------------------"
            read -p "do you went connect [$dbname]? (Y/N): " to_connect
            [[ "$to_connect" =~ ^[Yy]$ ]] && to_connect= TablesMainMenu 
        else
            echo -e "${RED}❌ Error: The database '$dbname' was not found.${NC}"
        fi
    done
}

