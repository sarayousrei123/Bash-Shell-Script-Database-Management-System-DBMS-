#!/bin/bash
function createDB {
	clear
	echo "********************************"
	echo "Here You Can Create Databases :)"
	echo "********************************"
	read -p "please enter the database name or 'exit' to return to main menu :)" dbname
	 while true; do
        	
	    if [[ $dbname == 'exit' ]]
	    then
		dbMainMenu
	   
	    elif [[ $dbname == *['!''?'@\#\$%^\&*()'-'+\.\/';']* ]] #special character
	    then
	    echo "database name can not contain any special character"
	read -p "please enter the database name or 'exit' to return to main menu :)" dbname
	    
	    elif [[ $dbname == *" "* ]] 
	    then
	    echo "database name can not contain spaces"
	read -p "please enter the database name or 'exit' to return to main menu :)" dbname
	    
	    elif [[ -z $dbname ]] #-z is string test operator that checks whether a variable or string is empty 
	    then
	    echo "database name can not be empty"
	read -p "please enter the database name or 'exit' to return to main menu :)" dbname

	    elif [[ -d "$DB_MAIN_DIR"/$dbname ]]
	    then
	    echo "this name already exists"
	read -p "please enter the database name or 'exit' to return to main menu :)" dbname

	    elif [[ $dbname =~ ^[0-9] ]]  
	    then
	    echo "database name can not begin with numbers"
	read -p "please enter the database name or 'exit' to return to main menu :)" dbname
	       
	    else
	    mkdir  "$DB_MAIN_DIR"/$dbname
	    echo "This database has been created successfully :)" 
	read -p "please enter the database name or 'exit' to return to main menu :)" dbname
	    fi
	    

	done  


}

