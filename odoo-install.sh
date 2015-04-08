#!/bin/bash
################################################################################
# Script for Installation on Ubuntu 14.04 LTS
# Author: Atul Arvind
#-------------------------------------------------------------------------------
# Note: You need to have Clean Ubuntu machine where no odoo is installed. Installation is for your current system user.
#-------------------------------------------------------------------------------
# odoo-install
#
# To Run the bash script execute the below command:
# sudo ./odoo-install 
#
################################################################################

SYS_BIT="32"
OE_VERSION="8.0"
OE_DIR="/home/software/workspace"

echo -e 'Instaling Odoo for ' $USER


echo -e 'Updating Server'
sudo apt-get update
sudo apt-get upgrade -y

echo -e 'Installing python packages'
sudo apt-get install python-dateutil python-feedparser python-ldap python-libxslt1 python-lxml python-mako python-openid python-psycopg2 python-pybabel python-pychart python-pydot python-pyparsing python-reportlab python-simplejson python-tz python-vatnumber python-vobject python-webdav python-werkzeug python-xlwt python-yaml python-zsi python-docutils python-psutil python-mock python-unittest2 python-jinja2 python-pypdf python-decorator python-requests python-passlib python-pil gdata -y

if [$sys_bit -eq "64"]; then 
 echo -e "\n Installing wkhtmltox for 64 bit system"
 sudo wget http://downloads.sourceforge.net/project/wkhtmltopdf/archive/0.12.1/wkhtmltox-0.12.1_linux-trusty-amd64.deb
 sudo dpkg -i wkhtmltox-0.12.1_linux-trusty-amd64.deb
 # sudo cp /usr/local/bin/wkhtmltopdf /usr/bin
 # sudo cp /usr/local/bin/wkhtmltoimage /usr/bin
else
 echo -e "\n Installing wkhtmltox for 32 bit system"
 wget http://downloads.sourceforge.net/project/wkhtmltopdf/0.12.2.1/wkhtmltox-0.12.2.1_linux-precise-i386.deb
 sudo dpkg -i wkhtmltox-0.12.2.1_linux-precise-i386.deb
 sudo cp /usr/local/bin/wkhtmltopdf /usr/bin

fi
echo -e '\nInstalling tool packages'
sudo apt-get install git python-pip -y

echo -e '\nInstall PostgreSQL Server'
sudo apt-get install postgresql -y
sudo su - postgres -c "createuser -s $USER"


echo -e "\nDownloading ODOO from github ===="
sudo git clone --branch $OE_VERSION https://www.github.com/odoo/odoo $OE_HOME_EXT/

tput clear
sleep 3
echo -e "\n Hurray..!"
sleep 1
echo -e "\n Your System is ready for Odoo Devlopment!"
sleep 1
echo -e "\n Thanks for Installing Odoo with http://odootraining.blogspot.com"
sleep 1

exit 0