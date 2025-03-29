function dropDB {
    clear
    echo "============================"
    echo "  🗑️  DELETE A DATABASE"
    echo "============================"
    echo "  🗃️  Available databases:"
    echo "==============================="
    ls -1 "$DB_MAIN_DIR"| awk '{print "📂 " $0}'

    while true; do
        read -p "Enter the database name to delete or  exit to return main menu " DB_NAME
        
        if [[ $DB_NAME == "exit" ]]; then
            dbMainMenu
            return
        fi

        DB_PATH="$DB_MAIN_DIR/$DB_NAME"
        if [[ -d "$DB_PATH" ]]; then
            echo -e "${YELLOW}⚠️  Warning: You are about to delete '$DB_NAME'. This action cannot be undone! ${NC}"
            read -p "Are you sure? [y/n]: " confirmation
            
            case $confirmation in
                [yY]) 
                    rm -rf "$DB_PATH"
                    echo -e "${GREEN}✅ Database '$DB_NAME' has been deleted successfully! ${NC}" 
                    ;;
                [nN]) 
                    echo -e "${BLUE}ℹ️  Operation cancelled. Returning to Main Menu... ${NC}" 
                    ;;
                *) 
                    echo -e "${RED}❌ Invalid input! Returning to Main Menu... ${NC}" 
                    ;;
            esac
        else
            echo -e "${RED}❌ Error: Database '$DB_NAME' does not exist! ${NC}"
        fi
    done
}

