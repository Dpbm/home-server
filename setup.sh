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
 

log "Setup static IP..."
echo "the new ip: "
read $new_ip
sudo su
echo "interface wlan0" >> /etc/dhcpcd.conf
echo "static ip_address=$new_ip/24" >> /etc/dhcpcd.conf
echo "static routers=192.168.0.1" >> /etc/dhcpcd.conf
echo "static domain_name_servers=192.168.0.1 1.1.1.1" >> /etc/dhcpcd.conf
exit



log "Activating VNC..."
sudo ln /usr/lib/systemd/system/vncserver-x11-serviced.service /etc/systemd/system/multi-user.target.wants/vncserver-x11-serviced.service
sudo systemctl start vncserver-x11-serviced
vncpasswd -user


log "Donwloading final dependecies..."
sudo apt install rkhunter
git clone https://github.com/goodtft/LCD-show $HOME


log "Disable Bluetooth..."
echo "dtoverlay=disable-bt" >> $HOME/LCD-show/boot/config.txt.bak


log "Setting up the 3.2inch Tft Screen..."
log "YOUR SYSTEM IS GOING TO RESTART AFTER THAT"
mkdir old-boot-config
sudo cp /boot/config.txt ./old-boot-config
cd $HOME/LCD-show
sudo ./LCD32-show


