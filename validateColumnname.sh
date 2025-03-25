#!/bin/bash

function validateColumnname {
    local columnname="$1"

    if [[ -z $columnname ]]; then
        echo -e "${RED}❌ Error: Column name cannot be empty.${NC}"
        return 1
    fi

    if [[ $columnname == *" "* ]]; then
        echo -e "${RED}❌ Error: Column name cannot contain spaces.${NC}"
        return 1
    fi

    if [[ $columnname == *['!''?'@\#\$%^\&*()'-'+\.\/';']* ]]; then
        echo -e "${RED}❌ Error: Column name cannot contain special characters.${NC}"
        return 1
    fi

    if [[ $columnname =~ ^[0-9] ]]; then
        echo -e "${RED}❌ Error: Column name cannot start with a number.${NC}"
        return 1
    fi

    return 0  
}

