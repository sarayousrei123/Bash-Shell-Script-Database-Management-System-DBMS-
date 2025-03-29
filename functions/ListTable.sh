#! /bin/bash
function ListTable {
    clear
    echo "==============================="
    echo "📋 Tables List in [$dbname] 📋"
    echo "==============================="

    while true; do
        read -p "🔹 Enter 1 to list all tables or 'exit' to return: " choose

        case $choose in
            "exit")
                TablesMainMenu
                return
                ;;
            "1")
                if [[ ! -d "$DB_MAIN_DIR/$dbname" || -z $(ls -A "$DB_MAIN_DIR/$dbname" 2>/dev/null) ]]; then
                    echo -e "}❌${RED}No tables found in '$dbname'!${NC}"
                else
                    echo "------------------------------------------"
                    echo "📂 Available Tables:"
                    ls -1 "$DB_MAIN_DIR/$dbname/" | awk '{print "📄 " $0}'  
                    echo "------------------------------------------"
                fi
                ;;
            *)
                echo -e "⚠️ ${RED}Invalid option! Please try again.${NC}"
                ;;
        esac
    done
}

