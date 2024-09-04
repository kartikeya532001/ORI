#!/bin/bash
cd /home/ubuntu/repo
sudo npm install
sudo npm install -g pm2
sudo pm2 start npm --name oriserve_aap -- start

