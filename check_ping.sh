#!/bin/bash

# Check if ping is successful
if ping -c 1 192.168.1.254 &> /dev/null
then
    # If ping is successful, check if the service is running
    if systemctl is-active --quiet wg-quick@wg0.service
    then
        # If the service is already running, do nothing
        :
    else
        # If the service is not running, start it
        systemctl start wg-quick@wg0.service
    fi
else
    # If ping is unsuccessful, stop the service and flush DNS cache
    sudo resolvectl flush-caches
    systemctl restart wg-quick@wg0.service
fi
