#!/bin/bash

function showDBs { 
    clear
    echo "=========================================="
    echo "📂       AVAILABLE DATABASES       📂"
    echo "=========================================="

    while true; do
        read -p "🔹 Enter 1 to  list all databases, enter 2 to search for a specific one, or 'exit' to return: " choose

        case $choose in
            "exit")
                dbMainMenu
                ;;
            "1")
                # Check if databases exist
                if [[ ! -d "$DB_MAIN_DIR" || -z $(find "$DB_MAIN_DIR" -mindepth 1 -type d 2>/dev/null) ]]; then
                    echo -e "${RED}❌ Sorry, no databases found!${NC}"
                else
                    echo "------------------------------------------"
                    echo "🗃️ Databases:"
                    ls -1 "$DB_MAIN_DIR" | awk '{print "📂 " $0}' 
                    echo "------------------------------------------"
                fi
                ;;
            "2")
                SpecificDB
                ;;
            *)
                echo -e "${RED}❌ Invalid option! Please try again.${NC}"
                ;;
        esac
    done
}

