#!/bin/bash
function dropDB {
       clear
        echo "*************************************"
	echo "can drobDB here:)"
	echo "*************************************"
    echo -n "Enter the Database Name to delete: "
    read DB_NAME

    DB_PATH="$DB_MAIN_DIR/$DB_NAME"

    if [[ -d "$DB_PATH" ]]; then
        echo -n "Are you sure you want to delete this database '$DB_NAME'? [y/n]: "
        read confirmation
        case $confirmation in
            [yY])
                rm -rf "$DB_PATH"
                echo -e "\e[41m Database '$DB_NAME' has been deleted successfully! \e[0m"
                ;;
            [nN])
                echo "Operation cancelled. Returning to Main Menu..."
                ;;
            *)
                echo "Invalid input! Returning to Main Menu..."
                ;;
        esac
    else
        echo -e "\e[41m Database '$DB_NAME' does not exist! \e[0m"
    fi
}
