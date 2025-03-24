#!/bin/bash

SCRIPT_DIR="$(dirname "$0")"  
DB_MAIN_DIR="$SCRIPT_DIR/Databases"  

if ! [[ -d "$DB_MAIN_DIR" ]]; then
    mkdir -p "$DB_MAIN_DIR"  #DB_MAIN_DIR 
fi

echo "***********************************************************************************************************"
echo ""
echo "                    Bash Shell Script Database Management System (DBMS)               "
echo "                        Telecom Application Development - Intake 45                  "
echo "                             Sara Yousrei Alsoyefeai Allsebeai                        "
echo "                                   Shrouq Haney Mohamed                               "
echo "***********************************************************************************************************"
echo ""

function welcomeScreen {
    PS3="Enter Your Option: "
    select choice in "Enter to your database" "Exit"; do
        case $REPLY in
            1) dbMainMenu ;; 
            2) echo "Exiting, Goodbye ..... "
            	 exit 0 ;;   
            *) echo "Invalid choice! Please enter 1 or 2" ;;
         
        esac
    done
}

function dbMainMenu {
    while true; do
        clear
        echo "********************** Main Menu ********************** "

        PS3="Enter your choice: "  
        options=("Select DB" "Create DB" "Rename DB" "Drop DB" "Show DBs" "Execute SQL Query" "Exit" )

        select choice in "${options[@]}"; do
            case $REPLY in
                1) selectDB ;; 
                2) createDB ;;  
                3) renameDB ;;
                4) dropDB   ;;  
                5) showDBs  ;;   
                6) executeSQL ;;   
                7) echo "Exiting..."; exit 0 ;;  
                *) echo "Invalid option! Please enter a number between 1-7" ;;
            esac
        done
    done
}

function renameDB {
    echo -n "Enter the current database name: "
    read old_name

    old_path="$DB_MAIN_DIR/$old_name"

    if [[ ! -d "$old_path" ]]; then
        echo -e "\e[31mDatabase '$old_name' does not exist!\e[0m"
        return
    fi

    echo -n "Enter the new database name: "
    read new_name

    new_path="$DB_MAIN_DIR/$new_name"

    if [[ -d "$new_path" ]]; then
        echo -e "\e[31mDatabase '$new_name' already exists!\e[0m"
        return
    fi

    mv "$old_path" "$new_path"
    echo -e "\e[32mDatabase renamed successfully from '$old_name' to '$new_name'!\e[0m"
} 

function dropDB {
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


welcomeScreen


