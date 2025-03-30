#!/bin/bash

function deleteFromTable {
    clear
    echo "============================================================================================================================================================"
    echo ""
    echo "                                                       🗑️  Delete Row by Primary Key in $dbname  🗑️"
    echo ""
    echo "============================================================================================================================================================"
    
    while true; do
        echo "📌 Available tables in '$dbname':"
        tables=$(ls "$DB_MAIN_DIR/$dbname" | grep -E '^[^_]+\.xml$' | sed 's/.xml$//' | awk '{print "📄 " $0}')
        
        if [[ -z "$tables" ]]; then
            echo -e "${RED_CRIMSON}❌ No tables found in '$dbname'! ${NC}"
            read -p "Press Enter to return to the main menu..." 
            TablesMainMenu
            return
        fi

        echo "$tables"
        read -p "Enter table name or type 'exit' to return:) " dtb
        if [[ "$dtb" == "exit" ]]; then
            TablesMainMenu
            return
        fi

        TABLE_PATH="$DB_MAIN_DIR/$dbname/$dtb.xml"
        META_PATH="$DB_MAIN_DIR/$dbname/${dtb}_meta.xml"

        if [[ ! -f "$TABLE_PATH" || ! -f "$META_PATH" ]]; then
            echo -e "${RED_CRIMSON}❌ Error: Table '$dtb' does not exist! ${NC}"
            continue
        fi

        # استخراج اسم الـ Primary Key باستخدام xmlstarlet
PK_COL=$(grep 'primaryKey="true"' "$META_PATH" | sed -n 's/.*name="\([^"]*\)".*/\1/p')



        if [[ -z "$PK_COL" ]]; then
            echo -e "${RED_CRIMSON}❌ Error: No Primary Key found in '$dtb'. ${NC}"
            continue
        fi

        echo "🔑 Primary Key Column: $PK_COL"
        
        while true; do
            read -p "Enter Primary Key value to delete the row (or type 'exit' to return): " pk_value
            if [[ "$pk_value" == "exit" ]]; then
                break
            fi

            if ! grep -q "<$PK_COL>$pk_value</$PK_COL>" "$TABLE_PATH"; then
                echo -e "${RED_CRIMSON}❌ No matching record found with PK='$pk_value'! ${NC}"
                continue
            fi

            # حذف الصف بالكامل إذا كان يحتوي على الـ PK المطلوب
sed -i "/<Row>/,/<\/Row>/ { /<$PK_COL>$pk_value<\/$PK_COL>/ {N; d} }" "$TABLE_PATH"


            echo -e "${GREEN}✅ Row with PK='$pk_value' deleted successfully! 🎉 ${NC}"
        done
    done
}

