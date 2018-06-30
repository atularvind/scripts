#!/bin/bash

OE_USER="iam"
OE_VERSION="11.0"
WS_URL="/home/$OE_USER/ws/odoo"
WKHTMLTOX_X64=https://downloads.wkhtmltopdf.org/0.12/0.12.1/wkhtmltox-0.12.1_linux-trusty-amd64.deb

echo -e "\n---- Update Server ----"
sudo apt-get update
sudo apt-get upgrade -y


echo -e "\n---- Install PostgreSQL Server ----"
sudo apt-get install postgresql -y

sudo su - postgres -c "createuser -s $OE_USER" 2> /dev/null || true

#--------------------------------------------------
# Install Dependencies
#--------------------------------------------------
echo -e "\n--- Installing Python 3 + pip3 --"
sudo apt-get install python3 python3-pip

echo -e "\n---- Install tool packages ----"
sudo apt-get install wget git bzr python-pip gdebi-core -y

echo -e "\n---- Install python 2.7 & 3.0 packages ----"
sudo apt-get install python-pypdf2 python-dateutil python-feedparser python-ldap python-libxslt1 python-lxml python-mako python-openid python-psycopg2 python-pybabel python-pychart python-pydot python-pyparsing python-reportlab python-simplejson python-tz python-vatnumber python-vobject python-webdav python-werkzeug python-xlwt python-yaml python-zsi python-docutils python-psutil python-mock python-unittest2 python-jinja2 python-pypdf python-decorator python-requests python-passlib python-pil -y
sudo pip3 install pypdf2 Babel passlib Werkzeug decorator python-dateutil pyyaml psycopg2 psutil html2text docutils lxml pillow reportlab ninja2 requests gdata XlsxWriter vobject python-openid pyparsing pydot mock mako Jinja2 ebaysdk feedparser xlwt psycogreen suds-jurko pytz pyusb greenlet xlrd 
sudo pip install pypdf2 Babel passlib Werkzeug decorator python-dateutil pyyaml psycopg2 psutil html2text docutils lxml pillow reportlab ninja2 requests gdata XlsxWriter vobject python-openid pyparsing pydot mock mako Jinja2 ebaysdk feedparser xlwt psycogreen suds-jurko pytz pyusb greenlet xlrd 

echo -e "\n---- Install python libraries ----"
# This is for compatibility with Ubuntu 16.04. Will work on 14.04, 15.04 and 16.04
sudo apt-get install python3-suds

echo -e "\n--- Install other required packages"
sudo apt-get install node-clean-css -y
sudo apt-get install node-less -y
sudo apt-get install python-gevent -y

echo -e "\n---- Install wkhtml and place shortcuts on correct place for ODOO ----"

sudo wget $WKHTMLTOX_X64
sudo gdebi --n `basename $WKHTMLTOX_X64`
sudo ln -s /usr/local/bin/wkhtmltopdf /usr/bin
sudo ln -s /usr/local/bin/wkhtmltoimage /usr/bin


echo -e "\n---- Creating Workspace ----"

mkdir -p $WS_URL && cd $WS_URL
sudo git clone --depth 1 --branch $OE_VERSION https://www.github.com/odoo/odoo $OE_VERSION
sudo git clone --depth 1 --branch 10.0 https://www.github.com/odoo/odoo 10.0
sudo git clone --depth 1 --branch 9.0 https://www.github.com/odoo/odoo 9.0
sudo git clone --depth 1 --branch 8.0 https://www.github.com/odoo/odoo 8.0

echo "alias 11='cd $WS_URL/11.0/'" >> ~/.bashrc
echo "alias 10='cd $WS_URL/10.0/'" >> ~/.bashrc
echo "alias 9='cd $WS_URL/9.0/'" >> ~/.bashrc
echo "alias 8='cd $WS_URL/8.0/'" >> ~/.bashrc
echo "alias hg='history | grep '" >> ~/.bashrc


