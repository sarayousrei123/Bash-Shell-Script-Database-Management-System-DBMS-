#!/bin/bash

SCRIPT_DIR="$(dirname "$0")"  
DB_MAIN_DIR="$SCRIPT_DIR/Databases"  

if ! [[ -d "$DB_MAIN_DIR" ]]; then
    mkdir -p "$DB_MAIN_DIR"  
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
            2) echo "Exiting, Goodbye ..... "; exit 0 ;;  
            *) echo "Invalid choice! Please enter 1 or 2." ;;  
        esac
    done
}

function dbMainMenu {
    while true; do
        clear
        echo "********************** Main Menu ********************** "

        PS3="Enter your choice: "  
        options=("Select DB" "Create DB" "Rename DB" "Drop DB" "Show DBs" "Execute SQL Query" "Exit" #"Back" )

        select choice in "${options[@]}"; do
            case $REPLY in
                1) selectDB; break ;;  
                2) createDB; break ;;  
                3) renameDB; break ;;  
                4) dropDB; break ;;  
                5) showDBs; break ;;  
                6) executeSQL; break ;;  
          #      7) echo "Returning to Welcome Screen...";
            #      	sleep 1; 
             #     	clear; 
           #       	return 0 
             #    	;; 
                7) echo "Exiting..."; exit 0 ;;  
                *) echo "Invalid option! Please enter a number between 1-8." ;;
            esac
        done
    done
}

welcomeScreen

