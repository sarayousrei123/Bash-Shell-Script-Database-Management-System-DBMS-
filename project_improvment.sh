#!/bin/bash

SCRIPT_DIR="$(dirname "$0")"  
DB_MAIN_DIR="$SCRIPT_DIR/Databases" 
source "$SCRIPT_DIR/functions/createDB.sh" 
source "$SCRIPT_DIR/functions/dbMainMenu.sh" 
source "$SCRIPT_DIR/functions/showDBs.sh" 
source "$SCRIPT_DIR/functions/showspeceficDB.sh" 
source "$SCRIPT_DIR/functions/dropDB.sh" 
source "$SCRIPT_DIR/functions/renameDB.sh" 

if ! [[ -d "$DB_MAIN_DIR" ]]; then
    mkdir -p "$DB_MAIN_DIR"  #DB_MAIN_DIR 
fi
clear
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
            2) echo "Exiting, Goodbye :( "; exit 0 ;;  
            *) echo "❌ Invalid option!";;  

        esac
    done
}

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

welcomeScreen


