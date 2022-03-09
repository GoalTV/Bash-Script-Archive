sudo apt update -y
sudo apt upgrade -y
sudo pihole -up
sudo sh /root/whitelist/scripts/optional.sh
sudo sh /root/whitelist/scripts/referral.sh
sudo sh /root/whitelist/scripts/whitelist.sh
sudo pihole -g
/sbin/shutdown -r +0
