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


run_command() {
    echo -e "$2\n"
    eval $1 &>/dev/null && sleep 2
    check_command "$2 failed"
}

# Check if already installed
[ -x "$(command -v docker)"  ] && echo "Docker already installed" && exit

run_command "sudo apt-get update" "Update system"

run_command "sudo apt-get install -y \
             apt-transport-https \
             ca-certificates \
             curl \
             gnupg-agent \
             software-properties-common" \
             "Installing Docker dependecies"

run_command "curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -" \
    "Adding Docker's official GPG key"

# Check signature
apt-key list 2> /dev/null | grep -q "0EBF CD88" 
check_command "Docker fingerprint verification failed"

run_command "sudo add-apt-repository \
   \"deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable\"" \
   "Adding Docker repository"

run_command "sudo apt-get update && sudo apt-get install -y docker-ce docker-ce-cli containerd.io" \
    "Installing Docker"

run_command "sudo usermod -aG docker $USER" \
    "Adding $USER to docker group"

run_command "sudo curl \
    -L \"https://github.com/docker/compose/releases/download/1.28.2/docker-compose-$(uname -s)-$(uname -m)\" \
    -o /usr/local/bin/docker-compose && \
    sudo chmod +x /usr/local/bin/docker-compose" \
    "Installing docker-compose"





