#!/bin/bash

function UpdateTable {
    clear
    echo "==========================================================================================================================================================="
    echo ""
    echo "  							✏️  Update Data in Table - $dbname ✏️"
    echo ""
    echo "==========================================================================================================================================================="
    echo "📌 Available Tables in '$dbname':)"
    echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------"
    ls "$DB_MAIN_DIR/$dbname" | grep -E '^[^_]+\.xml$' | sed 's/.xml$//' | awk '{print "📄 " $0}'
    echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------"

    while true; do
        read -p "Enter table name:) " tablename
        TABLE_PATH="$DB_MAIN_DIR/$dbname/$tablename.xml"
        META_PATH="$DB_MAIN_DIR/$dbname/${tablename}_meta.xml"

        if [[ ! -f "$TABLE_PATH" ]]; then
            echo -e "${RED_CRIMSON}❌  Table '$tablename' does not exist! ${NC}"
            continue
        fi
        break
    done

    # استخراج بيانات الأعمدة من meta.xml
    column_names=()
    column_types=()
    primary_key=""

    while read -r line; do
        col_name=$(echo "$line" | grep -oP 'name="\K[^"]+')
        col_type=$(echo "$line" | grep -oP 'type="\K[^"]+')
        is_primary=$(echo "$line" | grep -oP 'primaryKey="\K[^"]+')

        if [[ -n "$col_name" ]]; then
            column_names+=("$col_name")
            column_types+=("$col_type")
            [[ "$is_primary" == "true" ]] && primary_key="$col_name"
        fi
    done < "$META_PATH"

    # ✅ طباعة بيانات الأعمدة للتأكد من صحتها
    echo "🔍 Extracted Column Data:"
    for i in "${!column_names[@]}"; do
        echo "📌 Column: ${column_names[$i]} | Type: ${column_types[$i]}"
    done
    echo "➡️ Primary Key Extracted: $primary_key"

    # التأكد من العثور على مفتاح أساسي
    if [[ -z "$primary_key" ]]; then
        echo -e "${RED_CRIMSON}❌  Error: No primary key found in '$tablename'! ${NC}"
        return
    fi

    # ✅ عرض البيانات المتاحة في الجدول
    echo "📌 Existing Rows in '$tablename':"
    awk -F '[<>]' -v pk="$primary_key" '
        /<Row>/ {row=""; found=0}
        {
            for (i=2; i<=NF; i+=2) {
                if ($i == pk) {found=1}
                row = row $i " | "
            }
        }
        found {print row}
    ' "$TABLE_PATH"

    # 🔎 طلب قيمة المفتاح الأساسي لتحديث الصف
    read -p "Enter value of Primary Key ($primary_key) to update: " pk_value

    # التأكد من أن القيمة المدخلة موجودة في الجدول
    if ! grep -q "<$primary_key>$pk_value</$primary_key>" "$TABLE_PATH"; then
        echo -e "${RED_CRIMSON}❌ Error: No matching row found for PK = $pk_value ${NC}"
        return
    fi

    # 🔄 تحديث البيانات
    updated_values=()
    for i in "${!column_names[@]}"; do
        col_name="${column_names[$i]}"

        # استخراج القيمة القديمة
        old_value=$(grep -oP "(?<=<$col_name>).*?(?=</$col_name>)" "$TABLE_PATH" | grep -m1 "$pk_value" -A 1 | tail -n1)
        
        read -p "New value for $col_name (old: $old_value, press Enter to keep): " new_value
        [[ -z "$new_value" ]] && new_value="$old_value"

        updated_values+=("$new_value")
    done

    # تحديث السجل في XML
    for i in "${!column_names[@]}"; do
        col_name="${column_names[$i]}"
        sed -i "/<$primary_key>$pk_value<\/$primary_key>/,/\/Row>/s|<$col_name>.*</$col_name>|<$col_name>${updated_values[$i]}</$col_name>|" "$TABLE_PATH"
    done

    echo -e "${GREEN} ✅ Row with PK = $pk_value updated successfully! 🎉 ${NC}"
}

