#!/bin/bash

echo "Database Name: "
read -e dbname
echo "Database User: "
read -e dbuser
echo "Database Password: "
read -s dbpass

echo "Run install? (Y/N)"
read -e run

if [ "$run" == n ]; then
  exit
else
if [ "$run" == y ]; then
  # Install WordPress

  # Download
  curl -O http://wordpress.org/latest.tar.gz

  # Unzip
  tar -zxvf latest.tar.gz

  # Change dir to wordpress
  cd wordpress

  # Copy file to parent dir
  cp -rf . ..

  # Move back to parent dir
  cd ..

  # Remove files from wordpress folder     
  rm -R wordpress

  # Create wp-config
  cp wp-config-sample.php wp-config.php

  # Set database details with perl find and replace
  perl -pi -e "s/database_name_here/$dbname/g" wp-config.php
  perl -pi -e "s/username_here/$dbuser/g" wp-config.php
  perl -pi -e "s/password_here/$dbpass/g" wp-config.php

  # Create uploads folder and set permissions
  mkdir wp-content/uploads
  chmod 755 wp-content/uploads
  
  # Remove zip file
  rm latest.tar.gz

fi 

