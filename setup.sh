#!/bin/bash

GREEN='\033[0;32m'
END='\033[0m'

log(){
  text=$1
  echo -e "$GREEN$text$END"
}

log "Updating Everything..."
git clone https://github.com/Dpbm/update-all $HOME/update-all
echo 'alias update-all="$\HOME/udpate-all/update-all"' >> $HOME/.bashrc
source $HOME/.bashrc
update-all


log "Installing Docker..."
for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do sudo apt-get remove $pkg; done
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin


log "Testing Docker..."
sudo docker run hello-world
sudo docker container prune && sudo docker image prune -a


log "Changing Docker Users Permissions..."
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker


log "Setup Docker to Start on Startup..."
sudo systemctl enable docker.service
sudo systemctl enable containerd.service


log "Starting Containers..."
docker compose up -d


log "NOW YOUR SYSTEM WILL RESTART AND ALL WILL BE DONE!"
sleep 2
sudo reboot

