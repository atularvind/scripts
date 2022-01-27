#!/bin/bash

OE_USER="iam"
OE_VERSION="14.0"
WS_URL="/home/$OE_USER/ws/odoo"
WKHTMLTOX_X64=https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.5/wkhtmltox_0.12.5-1.buster_amd64.deb

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
sudo apt-get install python3 python3-pip git -y

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
sudo git clone --depth 1 --branch 13.0 https://www.github.com/odoo/odoo 13.0
sudo git clone --depth 1 --branch 12.0 https://www.github.com/odoo/odoo 12.0
sudo git clone --depth 1 --branch 11.0 https://www.github.com/odoo/odoo 11.0

echo "alias 14='cd $WS_URL/14.0/'" >> ~/.bashrc
echo "alias 13='cd $WS_URL/13.0/'" >> ~/.bashrc
echo "alias 12='cd $WS_URL/12.0/'" >> ~/.bashrc
echo "alias 11='cd $WS_URL/11.0/'" >> ~/.bashrc
echo "alias hg='history | grep '" >> ~/.bashrc


