#! /bin/bash

function deleteFromTable {
    clear
    echo "=========================================="
    echo "🗑️ Delete from Table in [$dbname]  🗑️"
    echo "=========================================="
    
    echo "What do you want to delete?"
    echo "1) Delete specific record"
    echo "2) Delete specific column"
    read -p "Enter your choice: " choice

    tables=$(ls "$DB_MAIN_DIR/$dbname" | grep -E '\.xml$' | sed 's/.xml$//')
    if [[ -z "$tables" ]]; then
        echo -e "${YELLOW} No tables found in '$dbname'! ${NC}"
        return
    fi

    echo "📌 Available tables in '$dbname':"
    echo "$tables"

    read -p "Enter table name: " dtb
    TABLE_PATH="$DB_MAIN_DIR/$dbname/$dtb.xml"
    META_PATH="$DB_MAIN_DIR/$dbname/${dtb}_meta.xml"

    if [[ ! -f "$TABLE_PATH" ]]; then
        echo -e "${RED} Error: Table '$dtb' does not exist! ${NC}"
        return
    fi

    case $choice in
        1) 
            read -p "Enter column name to search in: " coldel
            read -p "Enter value to delete: " vldel
            
            if ! grep -q "<$coldel>$vldel</$coldel>" "$TABLE_PATH"; then
                echo -e "${YELLOW} No matching record found! ${NC}"
                return
            fi

            sed -i "/<Row>/,/<\/Row>/ { /<$coldel>$vldel<\/$coldel>/d }" "$TABLE_PATH"
            echo -e "${GREEN} Record deleted successfully! ${NC}"
            ;;
        
        2) 
            read -p "Enter column name to delete: " coldel
            
            if ! grep -q "<Column name=\"$coldel\"" "$META_PATH"; then
                echo -e "${RED} Error: Column '$coldel' not found in table '$dtb'. ${NC}"
                return
            fi

            sed -i "s/<$coldel>.*<\/$coldel>//g" "$TABLE_PATH"
            sed -i "/<Column name=\"$coldel\"/d" "$META_PATH"

            echo -e "${GREEN} Column '$coldel' deleted successfully! ${NC}"
            ;;
        
        *) 
            echo -e "${RED} Invalid choice! ${NC}"
            ;;
    esac
}

