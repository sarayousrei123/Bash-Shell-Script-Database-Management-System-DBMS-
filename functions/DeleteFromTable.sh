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

    case $choice in
    
            echo "Available tables in $dbname:"
            ls "$DB_MAIN_DIR/$dbname" | grep -E '\.xml$' | sed 's/.xml$//'
            
            read -p "Enter table Name: " dtb
            TABLE_PATH="$DB_MAIN_DIR/$dbname/$dtb.xml"

            if [[ ! -f "$TABLE_PATH" ]]; then
                echo "Table '$dtb' does not exist!"
                return
            fi

            read -p "Enter column to delete record from: " coldel
            read -p "Enter value to delete: " vldel

            sed -i "/<$coldel>$vldel<\/$coldel>/d" "$TABLE_PATH"

            echo "Record deleted successfully!"
            ;;
        
            echo "Available tables in $dbname:"
            ls "$DB_MAIN_DIR/$dbname" | grep -E '\.xml$' | sed 's/.xml$//'
            
            read -p "Enter table Name: " dtb
            TABLE_PATH="$DB_MAIN_DIR/$dbname/$dtb.xml"
            META_PATH="$DB_MAIN_DIR/$dbname/${dtb}_meta.xml"

            if [[ ! -f "$TABLE_PATH" ]]; then
                echo "Table '$dtb' does not exist!"
                return
            fi

            read -p "Enter column name to delete: " coldel

            sed -i "/<$coldel>.*<\/$coldel>/d" "$TABLE_PATH"

            sed -i "/<Column name=\"$coldel\"/d" "$META_PATH"

            echo "Column '$coldel' deleted successfully!"
            ;;
        
        *) 
            echo "Invalid choice!"
            ;;
    esac
}

