#!/usr/bin/env bash

check_command(){
    if [ $? -ne 0 ]; then
        echo "$1"
        echo "Installation is not completed"  
        echo "Press any key to close..."  
        read
        exit
    fi
}


apt-key list 2> /dev/null | grep -q "0EBF CD88" 
check_command "Docker fingerprint verification failed"
