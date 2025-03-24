#!/bin/bash
function dbMainMenu {

        clear
        echo "*************************************"
	echo "Welcome to Our DataBase Main Menu :)"
	echo "*************************************"
    while true; do
        PS3="Enter your choice: "  
        options=("Select DB" "Create DB" "Rename DB" "Drop DB" "Show DBs" "Execute SQL Query" "Exit")

        select choice in "${options[@]}"; do
            case $REPLY in
                1) selectDB; break ;;  
                2) createDB; break ;;  
                3) renameDB; break ;;  
                4) dropDB; break ;;  
                5) showDBs; break ;;  
                6) executeSQL; break ;;  
                7) echo "Exiting, Goodbye :( "; exit 0 ;;  
                *) echo "❌ Invalid option!"
            esac
        done
    done
}

