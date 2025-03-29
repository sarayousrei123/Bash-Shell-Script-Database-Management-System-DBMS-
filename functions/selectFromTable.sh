#!/bin/bash

function selectFromTable {
    clear
    echo "=========================================="
    echo "🔍 Select Data from Table in $dbname 🔍"
    echo "=========================================="
    echo "📌 Available Tables in '$dbname':"
    ls "$DB_MAIN_DIR/$dbname" | grep -E '^[^_]+\.xml$' | sed 's/.xml$//' | awk '{print "📄 " $0}'
    echo "=========================================="

    while true; do
        read -p "Enter table name: " tablename
        TABLE_PATH="$DB_MAIN_DIR/$dbname/$tablename.xml"
        META_PATH="$DB_MAIN_DIR/$dbname/${tablename}_meta.xml"

        if [[ ! -f "$TABLE_PATH" || ! -f "$META_PATH" ]]; then
            echo -e "${RED} Table '$tablename' does not exist! ${NC}"
            echo "1. Retype table name"
            echo "2. Return to main menu"
            read -p "Choose (1/2): " choice
            case "$choice" in
                1) continue ;;
                2) TablesMainMenu;return ;;
                *) echo -e "${RED} Invalid choice! Try again. ${NC}";;
            esac
        else
            break
        fi
    done

    column_names=()
    
    while IFS=' ' read -r line; do
        if [[ "$line" =~ name=\"([^\"]+)\" ]]; then
            column_names+=("${BASH_REMATCH[1]}")
        fi
    done < <(grep "<Column " "$META_PATH")

    if [[ ${#column_names[@]} -eq 0 ]]; then
        echo -e "${RED} Error: No columns found in '$tablename'! ${NC}"
        return
    fi

    echo "📌 Available Columns in '$tablename':"
    for col in "${column_names[@]}"; do
        echo "  - $col"
    done
    echo "=========================================="

    read -p "Do you want to filter by a specific column? (y/n): " filter_choice
    if [[ "$filter_choice" =~ ^[Yy]$ ]]; then
        read -p "Enter column name to filter by: " filter_col
        if [[ ! " ${column_names[@]} " =~ " $filter_col " ]]; then
            echo -e "${RED} Error: Column '$filter_col' not found! ${NC}"
            return
        fi
        read -p "Enter value to filter by: " filter_value
        echo "=========================================="
        echo "🔍 Results for '$filter_col = $filter_value' in '$tablename':"
        echo "=========================================="
        awk -v col="$filter_col" -v val="$filter_value" '
            BEGIN { RS="<Row>"; FS="\n"; found=0 }
            {
                match($0, "<"col">"val"</"col">")
                if (RSTART) {
                    print "---------------------"
                    print "<Row>"
                    for (i=1; i<=NF; i++) print $i
                    print "</Row>"
                    found=1
                }
            }
            END { if (found==0) print "No matching records found." }
        ' "$TABLE_PATH"
    else
        echo "=========================================="
        echo "📄 All Data in '$tablename':"
        echo "=========================================="
        awk '
            BEGIN { RS="<Row>"; FS="\n" }
            NR>1 { 
                print "---------------------"
                print "<Row>"
                for (i=1; i<=NF; i++) print $i
                print "</Row>"
            }
        ' "$TABLE_PATH"
    fi

    echo "=========================================="
    read -p "Press Enter to return to the main menu..."
}

