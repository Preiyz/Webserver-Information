#!/bin/bash
#Owner: Praise
#Created: 04/02/2023
#Webserver script for information collection project

#This sequence confirms the user 
user=$(whoami)
if [ $user = ubuntu ]
then
	echo "Welcome!"
	sleep 1
	echo
	echo "Checking internet connection"
else
	echo "User not authorized. Please contact administrator"
	exit
fi

sleep 2
echo

#This sequence checks internet connection
host="www.google.com"
ping -c 3 $host > connectiontest
if [ $? = 0 ]
then
	echo "Internet connection is available"
	sleep 2
	echo >> connectiontest
	sudo apt-get update >> connectiontest
else
	echo "No connection error"
	exit
fi
clear

#This sequence check and downloads apache
echo >> connectiontest
apache=$(find /var/www/html -iname index.html)
if [ "$apache" = "/var/www/html/index.html" ]
then
	echo " I am now ready to collect your information"
	sleep 2
	sudo chmod 776 /var/www/html/index.html
	echo
else
	echo "Installing Apache2"
	sleep 2
	sudo apt-get install apache2
	sleep 2
	echo
	echo "Apache2 is now installed"
fi

#This sequence collects user information
echo "Are you willing to provide your information? (Y/N)"
read ans
if [ $ans = Y ] || [ $ans = y ] || [ $ans = Yes ] || [ $ans = YES ] || [ $ans = yes ]
then
	echo "What is your first name?"
	read name
	echo
	echo "What state do you reside?"
	read state
	echo
	echo "How old are you?"
	read age
	echo
	echo "How tall are you? (ft)"
	read tall
	echo
	echo "What is your gender?"
	read gender
	echo
	echo "Thank you for the provided information. Your information has been saved in the web database"
	sleep 5
	clear
else
	echo "Information will not be collected. Have a good day."
	sleep 2
	clear
fi

echo "
Name: $name
State: $state
Age: $age
Height: $tall ft
Gender: $gender" >> /var/www/html/index.html
echo >> /var/www/html/index.html
