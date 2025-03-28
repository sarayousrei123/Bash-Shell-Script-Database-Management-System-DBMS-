#! /bin/bash

function DropTable{
   clear
    echo "=========================================="
    echo "      🗑️ Drop Tables in [$dbname] 🗑️      "
    echo "=========================================="
    
    echo  "These Are The Available Tables in '$dbname' : " 
    ls "$DB_MAIN_DIR/$dbname" | grep -E '^[^_]+\.xml$'| sed 's/.xml$//' || echo -e "${YELLOW} No tables found! ${NC}" 

    read -p "enter the table  name you want to drop or 'exit' :" tablename
    [[ "$tablename" == "exit" ]] && echo -e "${YELLOW} operation was cancled ${NC}" && return
    
        TABLE_PATH="$DB_MAIN_DIR/$dbname/$tablename.xml"
        META_PATH="$DB_MAIN_DIR/$dbname/${tablename}_meta.xml"
        
 	if [[ -f "$TABLE_PATH" ]]; then 
 	read -p "Are You Sure You Want To Delete This '$tablename'? (Y/N) ": confirm 
 		if [[ "$confirm" =~ ^[Yy]$ ]]; then 
 				rm -f "$TABLE_PATH" "$META_PATH"
 		echo -e "${GREEN}Table $tablename was deleted successfully${NC}"
 		else 
 		echo -e "${RED}Deletion Was Cancled${NC}"
 		fi 
 	else 
 		echo -e "${RED}Table '$tablename' was not found${NC}"	
 	fi


}
