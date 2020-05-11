#!/bin/bash

#Author: Ator97
#Creation Date: 11-May-2020
#Last Modification: 11-May-2020
#Description
#	NOTE: This shell is designed to run in ArchLinux systems 
# 11-May-2020	For a moment, only add some aliases, desktop icons and make native some comands,
#							also install some base programs that i use
#


trap "" 2 20
trap "" SIGTSTP #Ctrl-z and Ctrl-c are trapped. Kill this process outside terminal

echo "Give me root password, Ctrl-z and Ctrl-C not allowed, finish only by outside"
read -s pswd #Keep the user password for future moves



#I assume that is a clean instalattion


#First, new aliases
echo "Aliases added"
echo "$pswd" | sudo -S cat bashrcConf >> ~/.bashrc
if [[ $?==0 ]];then
	echo "Done!"
else
	echo "Error"
	exit 0
fi


#Update and upgrade system
echo "Updating system"
sleep 3
echo "Wait"
sleep 3
echo "$pswd" | sudo -S pacman -Syu
if [[ $?==0 ]];then
  echo "Done!"
else
  echo "Error"
  exit 0
fi


#Install needed packages
echo "Installing base packages"
sleep 3
echo "$pswd" | sudo -S pacman -Syu python3 pip3 wine 
if [[ $?==0 ]];then
  echo "Done!"
else
  echo "Error installing packages"
  exit 0
fi

echo "$pswd" | sudo -S pip3 install upgrade pip
if [[ $?==0 ]];then
  echo "Done!"
else
  echo "Error installing pip"
  exit 0
fi

echo "$pswd" | sudo -S pip3 install jupyter
if [[ $?==0 ]];then
  echo "Done!"
else
  echo "Error installing jupyter"
  exit 0
fi



# Check jupyer-nohup file. We made it a local command system
echo "Adding new commands"
echo "$pswd" | sudo -S chmod 755 jupyter-nohup
echo "$pswd" | sudo -S chown root jupyter-nohup
echo "$pswd" | sudo -S chgrp root jupyter-nohup
echo "$pswd" | sudo -S mv jupyter-nohup /bin/

#Check erstudio file. We made it a local command system
echo "$pswd" | sudo -S chmod 755 erstudio
echo "$pswd" | sudo -S chown root erstudio
echo "$pswd" | sudo -S chgrp root erstudio
echo "$pswd" | sudo -S mv erstudio  /bin/

echo "Done"

#Add icons

echo "Adding desktops icons"


mv python-jupyter.desktop /usr/share/applications
mv erstudio.desktop /usr/share/applications

