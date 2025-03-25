#! /bin/bash

function createTable {
    clear
    echo "=========================================="
    echo "➕ Here You Can Create Tables in [$dbname]  ➕"
    echo "=========================================="

    while true; do
        read -p "Please enter a valid table name or type 'exit' to return: " tablename

        if [[ $tablename == "exit" ]]; then
            TablesMainMenu
            return
        fi

        validateDBName "$tablename"
        if [[ $? -ne 0 ]]; then
            continue  # إعادة الطلب إذا كان الاسم غير صالح
        fi

        TABLE_PATH="$DB_MAIN_DIR/$dbname/$tablename"

        if [[ -f "$TABLE_PATH" ]]; then
            echo -e "${RED}❌ Error: Table '$tablename' already exists!${NC}"
            continue
        fi


        touch "$TABLE_PATH"
        echo -e "${GREEN}✅ Table '$tablename' has been created successfully!${NC}"
    done
}

