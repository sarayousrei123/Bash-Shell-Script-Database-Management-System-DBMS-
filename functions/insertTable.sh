#!/bin/bash

function insertTable {
    clear
    echo "=========================================="
    echo "📝 Insert Data into Table in  $dbname  📝"
    echo "📌 Available Tables in       '$dbname':   "
    ls "$DB_MAIN_DIR/$dbname" | grep -E "^[a-zA-Z0-9_-]+\.xml$" | sed 's/\.xml$//'
    echo "=========================================="

    while true; do
        read -p "Enter table name: " tablename
        TABLE_PATH="$DB_MAIN_DIR/$dbname/$tablename.xml"
        META_PATH="$DB_MAIN_DIR/$dbname/${tablename}_meta.xml"

        if [[ ! -f "$TABLE_PATH" ]]; then
            echo -e "${RED} Table '$tablename' does not exist! ${NC}"
            echo "1. Create Table '$tablename'"
            echo "2. Retype table name"
            read -p "Choose (1/2): " choice
            case "$choice" in
                1) createTable; return ;;
                2) continue ;;
                *) echo -e "${RED} Invalid choice! Try again. ${NC}";;
            esac
        else
            break
        fi
    done

    column_names=()
    column_types=()
    column_constraints=()
    primary_key_index=-1

    while IFS=' ' read -r line; do
        if [[ "$line" =~ name=\"([^\"]+)\" ]]; then
            column_names+=("${BASH_REMATCH[1]}")
        fi
        if [[ "$line" =~ type=\"([^\"]+)\" ]]; then
            column_types+=("${BASH_REMATCH[1]}")
        fi
        if [[ "$line" =~ primary=\"([^\"]+)\" ]]; then
            primary_key_index=${#column_names[@]}-1
        fi
        if [[ "$line" =~ unique=\"([^\"]+)\" ]]; then
            column_constraints+=("${BASH_REMATCH[1]}")
        fi
    done < <(grep "<Column " "$META_PATH")

    if [[ ${#column_names[@]} -eq 0 ]]; then
        echo -e "${RED} Error: No columns found in '$tablename'! ${NC}"
        return
    fi

    echo "📌 Detected Columns in '$tablename':"
    for i in "${!column_names[@]}"; do
        echo "  - ${column_names[$i]} (Type: ${column_types[$i]})"
    done

    row_values=()

    for i in "${!column_names[@]}"; do
        col_name="${column_names[$i]}"
        col_type="${column_types[$i]}"
        is_unique="${column_constraints[$i]}"
        
        while true; do
            read -p "Enter value for $col_name ($col_type): " col_value

            if [[ "$col_type" == "string" && ! "$col_value" =~ ^[a-zA-Z\ ]+$ ]]; then
                echo -e "${RED} Error: $col_name must contain only letters and spaces! ${NC}"
                continue
            elif [[ "$col_type" == "int" && ! "$col_value" =~ ^[0-9]+$ ]]; then
                echo -e "${RED} Error: $col_name must contain only numbers! ${NC}"
                continue
            fi

            if [[ "$is_unique" == "true" && -n "$col_value" ]]; then
                if grep -q "<$col_name>$col_value</$col_name>" "$TABLE_PATH"; then
                    echo -e "${RED} Error: Value for $col_name must be unique! ${NC}"
                    continue
                fi
            fi

            row_values+=("$col_value")
            break
        done
    done

    sed -i '$d' "$TABLE_PATH"
    echo "  <Row>" >> "$TABLE_PATH"
    for i in "${!column_names[@]}"; do
        echo "    <${column_names[$i]}>${row_values[$i]}</${column_names[$i]}>" >> "$TABLE_PATH"
    done
    echo "  </Row>" >> "$TABLE_PATH"
    echo "</Table>" >> "$TABLE_PATH"

    echo -e "${GREEN} Data inserted successfully into '$tablename'. ${NC}"

    while true; do
        read -p "Do you want to return to the main menu (1) or insert another row (2)? " choice
        case $choice in
            1) clear; return ;;  
            2) clear; break ;;  
            *) echo -e "${RED} Invalid choice! Please enter 1 or 2. ${NC}" ;;
        esac
    done
}

