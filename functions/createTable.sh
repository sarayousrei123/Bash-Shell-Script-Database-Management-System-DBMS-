#!/bin/bash

function createTable {
    clear
    echo "=========================================="
    echo "➕ Create Tables in [$dbname]  ➕"
    echo "=========================================="

    while true; do 
        read -p "Enter table name or type 'exit': " tablename
        [[ "$tablename" == "exit" ]] && clear && return 

        TABLE_PATH="$DB_MAIN_DIR/$dbname/$tablename.xml"
        META_PATH="$DB_MAIN_DIR/$dbname/${tablename}_meta.xml"

        if [[ -f "$TABLE_PATH" ]]; then
            echo -e "${RED}  Table '$tablename' already exists!${NC}"
            continue
        fi

        read -p "Enter number of columns: " col_count
        if ! [[ "$col_count" =~ ^[1-9][0-9]*$ ]]; then
            echo -e "${RED}  Invalid Column Count!${NC}"
            continue
        fi


        echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?>" > "$TABLE_PATH"
        echo "<Table name=\"$tablename\">" >> "$TABLE_PATH"
        echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?>" > "$META_PATH"
        echo "<TableMeta name=\"$tablename\">" >> "$META_PATH"
        echo "  <Columns count=\"$col_count\">" >> "$META_PATH"

        declare -A column_names  
        primary_key_count=0  

        for ((j = 1; j <= col_count; j++)); do
            col_name=""
            col_type=""

            while true; do
                read -p "Enter column name: " col_name
                validateColumnname "$col_name" && break
            done

            while true; do
                read -p "Data Type (string/int): " col_type
                if [[ "$col_type" =~ ^(string|int)$ ]]; then
                    break
                else
                    echo -e "${RED} Invalid choice, please enter 'string' or 'int' ${NC}"
                fi
            done

            read -p "Is this the Primary Key? (Y/N): " is_pk
            if [[ "$is_pk" =~ ^[Yy]$ ]]; then
                is_pk="true"
                ((primary_key_count++))
            else
                is_pk="false"
            fi

            read -p "Unique? (Y/N): " is_unique
            [[ "$is_unique" =~ ^[Yy]$ ]] && is_unique="true" || is_unique="false"

            read -p "Nullable? (Y/N): " is_nullable
            [[ "$is_nullable" =~ ^[Yy]$ ]] && is_nullable="true" || is_nullable="false"

            echo "<Column name=\"$col_name\" type=\"$col_type\" primaryKey=\"$is_pk\" unique=\"$is_unique\" nullable=\"$is_nullable\" />" >> "$META_PATH"
        done

        if [[ "$primary_key_count" -eq 0 ]]; then
            echo -e "${YELLOW} Warning: No Primary Key defined! Continue without PK? (Y/N) ${NC}"
            read choice
            [[ ! "$choice" =~ ^[Yy]$ ]] && echo -e "${RED}  Table creation canceled${NC}" && rm -f "$TABLE_PATH" "$META_PATH" && return
        fi

        echo "  </Columns>" >> "$META_PATH"
        echo "</TableMeta>" >> "$META_PATH"
        echo "</Table>" >> "$TABLE_PATH"

        echo -e "${GREEN} Table '$tablename' created successfully ${NC}"

        while true; do
            read -p "Do you want to return to the main menu (1) or add another table (2)? " choice
            case $choice in
                1) return ;;   
                2) clear ; break ;;  
                *) echo -e "${RED}Invalid choice! Please enter 1 or 2.${NC}" ;;
            esac
        done

    done
}

