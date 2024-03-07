#!/bin/bash

# wait for initial setup for aws instance
sleep 2;

sudo timedatectl set-timezone Asia/Seoul

sudo apt update -y
sudo apt install -y nginx

sudo systemctl enable nginx
sudo systemctl start nginx

sudo systemctl stop ufw
sudo systemctl disable ufw
