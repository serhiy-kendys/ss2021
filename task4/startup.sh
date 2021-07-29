#!/bin/bash
apt update -y
apt full-upgrade -y
apt install apache2 -y
systemctl restart apache2
echo "Sehr Gut!"
