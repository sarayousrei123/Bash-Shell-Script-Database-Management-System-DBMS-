#!/bin/bash

SCRIPT_DIR="$(dirname "$0")"  
DB_MAIN_DIR="$SCRIPT_DIR/Databases" 
source "$SCRIPT_DIR/functions/createDB.sh" 
source "$SCRIPT_DIR/functions/dbMainMenu.sh" 
source "$SCRIPT_DIR/functions/showDBs.sh" 
source "$SCRIPT_DIR/functions/showspeceficDB.sh" 
source "$SCRIPT_DIR/functions/dropDB.sh" 
source "$SCRIPT_DIR/functions/renameDB.sh" 
source "$SCRIPT_DIR/functions/selectDB.sh" 
source "$SCRIPT_DIR/functions/TablesMainMenu.sh"
source "$SCRIPT_DIR/functions/validateDBName.sh" 
source "$SCRIPT_DIR/functions/colors.sh" 

if ! [[ -d "$DB_MAIN_DIR" ]]; then
    mkdir -p "$DB_MAIN_DIR"  #DB_MAIN_DIR 
fi
clear
echo "***********************************************************************************************************"
echo -e "${YELLOW}                                                                                                          ${NC}"
echo -e "${YELLOW}                    🚀 Bash Shell Script Database Management System (DBMS)                               ${NC}"
echo -e "${YELLOW}                        Telecom Application Development - Intake 45                                      ${NC}"
echo -e "${BLUE}                             ⭐ Sara Yousrei Alsoyefeai Allsebeai                                         ${NC}"
echo -e "${GREEN}                             ⭐ Shrouq Haney Mohamed                                                      ${NC}"
echo -e "${YELLOW}                                                                                                          ${NC}"
echo "***********************************************************************************************************"
echo ""


function welcomeScreen {
    PS3="Enter Your Option: "
    select choice in "Enter to your database" "Exit"; do
        case $REPLY in

            1) dbMainMenu ;;  
            2) echo "Exiting, Goodbye :( "; exit 0 ;;  
            *) echo -e "${RED}❌ Invalid option!${NC}";;  

        esac
    done
}

       

welcomeScreen


