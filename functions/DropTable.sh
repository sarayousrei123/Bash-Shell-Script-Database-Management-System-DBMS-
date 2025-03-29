#! /bin/bash

function DropTable {
    echo "=========================================="
    echo "      🗑️ Drop Tables in [$dbname] 🗑️      "
    echo "=========================================="

    echo "These Are The Available Tables in '$dbname':"

    available_tables=$(ls "$DB_MAIN_DIR/$dbname" | grep -E '^[^_]+\.xml$' | sed 's/.xml$//')
    
    if [[ -z "$available_tables" ]]; then
        echo -e "${YELLOW}No tables found!${NC}"
        return
    else
        echo "$available_tables"
    fi

    read -p "Enter the table name you want to drop or 'exit': " tablename
    [[ "$tablename" == "exit" ]] && echo -e "${YELLOW}Operation was canceled.${NC}" && return

    TABLE_PATH="$DB_MAIN_DIR/$dbname/$tablename.xml"
    META_PATH="$DB_MAIN_DIR/$dbname/${tablename}_meta.xml"

    if [[ -f "$TABLE_PATH" ]]; then
        read -p "Are you sure you want to delete '$tablename'? (Y/N): " confirm
        if [[ "$confirm" =~ ^[Yy]$ ]]; then
            rm -f "$TABLE_PATH"
            [[ -f "$META_PATH" ]] && rm -f "$META_PATH"
            echo -e "${GREEN}Table '$tablename' was deleted successfully.${NC}"
        else
            echo -e "${RED}Deletion was canceled.${NC}"
        fi
    else
        echo -e "${RED}Table '$tablename' was not found.${NC}"
    fi
}

