#! /bin/bash

function createTable {
    clear
    echo "=========================================="
    echo "➕ Here You Can Create Tables in [$dbname]  ➕"
    echo "=========================================="

    while true; 
    do
        read -p "Please enter a valid table name or type 'exit' to return: " tablename

        if [[ $tablename == "exit" ]]; then
            TablesMainMenu
            return
        fi

        validateDBName "$tablename"
        if [[ $? -ne 0 ]]; then
            continue  
        fi

     read -p "How many tables do you want to create? " table_count

    i=1
    while [[ $i -le $table_count ]]; do
        read -p "Enter name for Table #$i: " tablename
        TABLE_PATH="$DB_MAIN_DIR/$dbname/$tablename"
        META_PATH="$DB_MAIN_DIR/$dbname/${tablename}_meta"

        if [[ -f "$TABLE_PATH" ]]; then
            echo -e "${RED}❌ Table '$tablename' already exists!${NC}"
            continue
        fi

        read -p "Enter number of columns for '$tablename': " col_count
        echo "Table:$tablename" > "$META_PATH"
        echo "Columns:$col_count" >> "$META_PATH"

        j=1
        while [[ $j -le $col_count ]]; do
            read -p "Column $j Name: " col_name
            read -p "Data Type (string/int): " col_type
            read -p "Primary Key? (Y/N): " is_pk
            echo "$col_name|$col_type|PK:$is_pk" >> "$META_PATH"
            ((j++))
        done

        touch "$TABLE_PATH"
        echo -e "${GREEN}✅ Table '$tablename' created successfully!${NC}"
        ((i++))
    done
}

