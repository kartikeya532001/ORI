#!/bin/bash

if [ ! -d /home/ubuntu/repo ]; then 
    exit 0
else
    cd /home/ubuntu/repo/
    sudo pm2 stop oriserve_aap
    sudo pm2 delete oriserve_aap
    cd /home/ubuntu/ && sudo rm -rf repo
fi
