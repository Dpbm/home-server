# Home Server Setup

<img src="./assets/system.jpeg" />

This project aims to store all the configurations I've been doing in my mini home server.

Till now, the server consists in a single raspberry pi 3B with a TFT 3.2' screen and a external HD attached. This one, is using the Raspberry pi OS (Bullseye).

In that, I'm running some docker containers which can be accessed through my whole home network. The containers are:

- Jellyfin
- Portainer
- GitPod
- AdGuardHome



## Setup

To setup a server like this one, first install the Raspberry pi OS (Bullseye) 64-Bit, to do that you may use the [rpi-imager](https://www.raspberrypi.com/software/) or, if you prefer, download the `img` file and flash it to your SD Card using another software of your preference.

![rpi-imager - flashing the system](./assets/pi%20imager.png)

Then plug your SD card into your Raspberry pi, configure your network, and then your ssh connection.

```bash
sudo raspi-config

# then go to Interfacing Options > SSH
```

After that, ensure you configured the ssh for key only logging, you can understand it better [here](https://www.digitalocean.com/community/tutorials/how-to-configure-ssh-key-based-authentication-on-a-linux-server).

Doing that, you can use ssh to connect remotely to your server using `putty` or command line:

```bash
ssh username@the-ip-of-your-raspberry-pi
```

Finally, run the script:


```bash
#in your raspberry pi
git clone https://github.com/Dpbm/home-server
cd ./home-server/
chmod +x setup.sh
./setup.sh
```

At the end of the process, your raspberry pi will reboot to apply all the changes.

`Note: the process set a static ip for your server, ensure you fixed it in your router configurations, and also that the selected ip will not collide with other devices' ips`

## Accessing services

To access the server's services, you can go to:

- `http://your-raspbery-pi-ip:8096/` for `Jellyfin`
- `https://your-raspbery-pi-ip:9443/` for `Portainer`
- `https://your-raspbery-pi-ip:3004/` for `GitPod`
- `https://your-raspbery-pi-ip:3000/` for `AdGuardHome` `obs (the port 3000 may change after further configurations)`