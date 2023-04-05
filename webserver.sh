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
	echo "Please give me a moment to check your internet connection"
else
	echo "Sorry, you are not authorized to run this script"
	echo "Please contact your administrator for authorization"
	echo "Have a good day"
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
	echo "apache is already installed"
	echo " I am now ready to collect your information"
	sleep 2
	sudo chmod 776 /var/www/html/index.html
	echo
else
	echo "Installing Apache2"
	sleep 2
	sudo apt-get install apache2 >> /dev/null
	sleep 2
	echo
	echo "Apache2 is now installed"
fi

#This sequence collects user information
echo "Are you willing to provide your information? (Y/N)"
read ans
while [ $ans = Y ] || [ $ans = y ] || [ $ans = Yes ] || [ $ans = YES ] || [ $ans = yes ]
do
	echo "Thanks for willing to provide your information"
	answ=N
		while [ $answ = N ] || [ $answ = n ] || [ $answ = NO ] || [ $answ = no ] || [ $answ = No ]
		do
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
			echo "Thank you for the provided information."
			echo "
			Name: $name
			State: $state
			Age: $age
			Height: $tall ft
			Gender: $gender"
			echo
			echo "Does this information look correct to you?"
			read answ
		done

echo "
<h2> Name: $name </h2>
<h2> State: $state </h2>
<h2> Age: $age </h2>
<h2> Height: $tall ft </h2>
<h2> Gender: $gender </h2>" >> /var/www/html/index.html
echo "
" >> /var/www/html/index.html

echo
echo
echo "Processing...."
sleep 2
echo "I have saved your personal information to the web server"
echo "Would you like to provide another persons information? (Y/N)"
read ans
done

echo "Thanks for your time. See you later!"
