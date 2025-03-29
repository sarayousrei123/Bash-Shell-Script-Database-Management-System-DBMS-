#! /bin/bash

function DropTable {
clear
    echo "=========================================="
    echo "      🗑️ Drop Tables in $dbname 🗑️      "
    echo "=========================================="

    echo "These Are The Available Tables in '$dbname':"

    available_tables=$(ls "$DB_MAIN_DIR/$dbname" | grep -E '^[^_]+\.xml$' | sed 's/.xml$//')
    
    if [[ -z "$available_tables" ]]; then
        echo -e "${RED}❌ No tables found!${NC}"
        
    else
        echo "$available_tables"
    fi
while true ;do
    read -p "Enter the table name you want to drop or  'exit': " tablename

    if [[ $tablename == "exit" ]]; then
            TablesMainMenu
            return
        fi             

    TABLE_PATH="$DB_MAIN_DIR/$dbname/$tablename.xml"
    META_PATH="$DB_MAIN_DIR/$dbname/${tablename}_meta.xml"

    if [[ -f "$TABLE_PATH" ]]; then

         echo -e "${YELLOW}⚠️  Warning: You are about to delete '$tablename'. This action cannot be undone! ${NC}"
            read -p "Are you sure? [y/n]: " confirm
        
        if [[ "$confirm" =~ ^[Yy]$ ]]; then
            rm -f "$TABLE_PATH"
            [[ -f "$META_PATH" ]] && rm -f "$META_PATH"
            echo -e "${GREEN}✅  Table '$tablename' was deleted successfully.${NC}"
        else
            echo -e "${BLUE}ℹ️  Deletion was canceled.${NC}"
        fi
    else
        echo -e "${RED}❌ Table '$tablename' was not found.${NC}"
    fi
  done  
}

