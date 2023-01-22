#!/bin/bash

# A regular check will be performed to verify if WireGuard is active by pinging an internal device on IP address 192.168.1.254. 
# If WireGuard is already active, no action will be taken. In the event that WireGuard is not running, an attempt will be made to start it. 
# If the ping is unsuccessful, the DNS will be flushed to account for any changes in the domain's IP address, and WireGuard will be restarted. 
# This check will be scheduled to run every minute using cron.

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
