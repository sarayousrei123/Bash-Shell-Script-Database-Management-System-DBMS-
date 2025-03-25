#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
DB_MAIN_DIR="$SCRIPT_DIR/Databases" 

for file in "$SCRIPT_DIR/functions/"*.sh; 
do
    source "$file"
done

if ! [[ -d "$DB_MAIN_DIR" ]]; then
    mkdir -p "$DB_MAIN_DIR"  #DB_MAIN_DIR 
fi
clear

echo "***********************************************************************************************************"
echo -e "${YELLOW}                                                                                                          ${NC}"
echo -e "${YELLOW}                    🚀 Bash Shell Script Database Management System (DBMS) 🚀                             ${NC}"
echo -e "${YELLOW}                        Telecom Application Development - Intake 45                                      ${NC}"
echo -e "${Cyan}                             ⭐ Sara Yousrei Alsoyefeai Allsebeai ⭐                                    ${NC}"
echo -e "${Purple}                                  ⭐ Shrouq Haney Mohamed ⭐                                           ${NC}"
echo -e "${YELLOW}                                                                                                          ${NC}"
echo "***********************************************************************************************************"
echo ""


function welcomeScreen {

    PS3="Enter Your Option: "
    select choice in "Enter to your database" "Exit"; 
    do
        case $REPLY in
            1) dbMainMenu ;;  
            2) echo "Exiting, Goodbye :( "; exit 0 ;;  
            *) echo -e "${RED}❌ Invalid option!${NC}";;  

        esac
    done
}

       

welcomeScreen


