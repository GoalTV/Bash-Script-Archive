#!/bin/bash

# Update and upgrade the system
sudo apt update -y && sudo apt upgrade -y

# Run Pi-hole update
sudo pihole -up

# Run whitelist scripts
sudo sh /root/whitelist/scripts/optional.sh
sudo sh /root/whitelist/scripts/referral.sh
sudo sh /root/whitelist/scripts/whitelist.sh

# Regenerate Pi-hole blocklists
sudo pihole -g

# Check the exit status of the previous command
if [ $? -eq 0 ]; then
    # Reboot the system
    exec /sbin/shutdown -r +0
else
    echo "An error occurred.
