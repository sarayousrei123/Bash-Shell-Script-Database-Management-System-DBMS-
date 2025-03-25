#!/bin/bash

function selectDB {
    clear
    echo "==============================="
    echo "     🔗 CONNECT TO DATABASE    "
    echo "==============================="
    echo "📂 Available databases:"
    ls -1 "$DB_MAIN_DIR"

    while true; do
        read -p "Enter database name or type 'exit' to return: " dbname

        if [[ $dbname == "exit" ]]; then

            dbMainMenu
            return
        fi

        validateDBName "$dbname"
        if [[ $? -ne 0 ]]; then
            continue
        fi

        if [[ -d "$DB_MAIN_DIR/$dbname" ]]; then
            echo -e "${GREEN}✅ Successfully connected to '$dbname'!${NC}"

            TablesMainMenu
            return
        else
            echo -e "${RED}❌ Error: Database '$dbname' does not exist.${NC}"
        fi
    done
}

