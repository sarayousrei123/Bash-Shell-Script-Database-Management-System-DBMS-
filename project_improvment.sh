#! /bin/bash

echo "***********************************************************************************************************"
echo ""
echo "                    Bash Shell Script Database Management System (DBMS)               "
echo "                        Telecom Application Development - Intake 45                  "
echo "                             Sara Yousrei Alsoyefeai Allsebeai                        "
echo "                             shrouq haney mohamed                                    "
echo "***********************************************************************************************************"
echo ""

echo "Enter Your Option : "
select choice in "Enter To Your Database" "Exit" ; do

case $REPLY in
	1) 
	echo "Entering To Database ...."
	;;
	2)
	echo "Exiting , Goodbye ..... "
	exit 0
	;;
	*)
	echo "Invalid OPtion PLease Choose Either FRom 1 or 2 ONly "
	;;
esac
done 

