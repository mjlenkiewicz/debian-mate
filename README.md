# Linux in a Docker Container > Debian-Mate for DEVs

Docker is designed to run applications within isolated environments, and Linux distributions can be the base for these containers.

Here you have the dockerfile and all the extra files for building and running a fully containerized Linux Debian 12 "Bookworm" with Mate Desktop environment for development, testing, and debugging or running networking tools.

IMPORTANT: The dockerfile isn't already optimized because that could help for better understanding to those who are not familiar with docker/container tech.

Happy coding/debugging !!!

---

## Table of Contents
[Description](#description)</br>
[Project Status](#project-status)</br>
[Features & Software Management](#features)</br>
[Installation](#installation)</br>
[User Credentials](#user-credentials)</br>
[Access to MATE GUI](#access-to-mate-gui)</br>
[Post-Deployment Workflow](#post-deployment-workflow)</br> 
[Contributing](#contributing)</br> 
[Licenses](#licenses)</br> 
[Contact](#contact)</br>
[References](#references)</br>

---

## Description

This container provides a secure environment for testing purposes. While containers aren't
traditionally designed for persistent workspaces, proper configuration can make them highly effective for this use case.

## Project Status

The project is currently under development and testing; however, you can use it in production by following all security software recommendations and changing the default users credentials/passwords.

## Features
The container features network debugging and simulation tools such as:
* visual studio code
* miniconda3
    - python 3.9 virtual environment (py39env)
* nodejs & npm
* git & all sub-packages
* network file sharing tools
    - samba (for connecting to Windows network shared directories through dir. explorer «CAJA»)
    - filezilla client
* networking tools:
    - ethtool
    - net-tools
    - iputils-ping
    - traceroute
    - tcpdump
    - nmap
    - wireshark (is not installed; if you would like to install it, uncomment the corresponding lines)

## Software Management
If you do not require the included software, comment out or remove the corresponding entries in the Dockerfile, and/or you can extend functionality by adding custom software modifying the dockerfile or using a runtime installation, but remember that changes made during runtime (via GUI/terminal) will be ephemeral unless you commit the modified container to a new image or update the original Dockerfile and rebuild.

## Installation

You must have installed docker engine (Linux) or docker desktop (Windows) !!!

> for Linux see ...</br>
https://docs.docker.com/engine/install/</br>
> for Windows see ...</br>
https://docs.docker.com/desktop/setup/install/windows-install/</br>

Then, with the files already on your PC run the following commands ...

#### 1) create a network for using with the container
#### on Linux
```
sudo docker network create -d bridge --subnet 192.168.5.0/24 --gateway 192.168.5.1 mydockernet
```
#### on Windows
Same as before without sudo command.

#### 2) build the container image usign the dockerfile provided
#### on Linux
```
sudo docker build -f Dockerfile.mate -t debian-mate:dev .
```
#### on Windows
Same as before without sudo command.
    
#### 3) run the container (you must see the bash when it started, then read User Credentials and Access to MATE GUI sections)
#### on Linux
```
sudo docker run --rm -ti -p 3390:3389 --net=mydockernet --ip="192.168.5.5" --cap-add=NET_ADMIN --cap-add=NET_RAW --cap-add=SYS_ADMIN --cap-add=CAP_DAC_READ_SEARCH -h debian debian-mate:dev
```
#### on Windows
Same as before without sudo command.


## Command "docker run" options reference:
--rm</br>
_Automatically removes the container when it stops or exits. Useful for temporary testing where persistence isn’t needed._

-ti Combines two options:</br>
-t: _Assigns a pseudo-TTY for an interactive interface._</br>
-i: _Keeps the standard input open for container interaction._</br>

-p 3390:3389</br>
_Maps port 3389 inside the container to port 3390 on the host, enabling external access to services running in the container._

--net=mydockernet</br>
_Connects the container to a custom Docker network named mydockernet, allowing communication with other containers on the same network._

--ip="192.168.5.5"</br>
_Assigns a static IP address (192.168.5.5) within the specified network (mydockernet). Requires a network driver that supports static IPs (e.g., bridge)._

--cap-add</br>
_Adds Linux capabilities to the container:_</br>
a» NET_ADMIN: Allows modifying network interfaces.</br>
b» NET_RAW: Enables advanced network operations (e.g., raw sockets).</br>
c» SYS_ADMIN: Grants system-level access (e.g., mounting devices).</br>
d» CAP_DAC_READ_SEARCH: Permits reading files/directories even if not explicitly permitted.</br>

a/b _are needed for wireshark, tcpdump, etc_</br>
c/d _are needed for mounting volumen & using samba_</br>

-h debian</br>
_Sets the container’s hostname to debian, visible in commands like hostname._

## User Credentials
1)
    >USER = root</br>
    >PASS = root9355</br>
2)
    >USER = test</br>
    >PASS = test9455</br>

IMPORTANT: To modify passwords, edit the Dockerfile and regenerate hashed credentials using Cryptool's OpenSSL tool on https://www.cryptool.org/en/cto/openssl (use the command _"openssl passwd -6"_ and follow the steps")

## Access to MATE GUI
Since you will not use a Linux system in a traditional way, you can only access the MATE GUI via RDP (remote desktop protocol) by connecting to localhost:3390 and using the provided user credentials. We recommend using the 'test' user with sudo for privileged operations.

Once you're inside the GUI, open a terminal and ...

1) If you want to run "conda" cmd to activate virtual envs (there is one already created called "py39env") ...
```
source /opt/miniconda3/etc/profile.d/conda.sh
```
<emsp>... and then ...
```
conda activate py39env
```

2) If you want to make available a network shared directory ...
```
sudo mkdir /mnt/<your mounting point>
```
... and then ...
```
sudo mount -t cifs //<your server IP address>/<your shared directory> /mnt/<your mounting point> -o username='<your network user>',password='<your network pass>',domain='<your domain name>',uid=1000,gid=1000,nofail
```

... fill it with your correct data and execute them !!!

## Post-Deployment Workflow
a) Temporary Use: No further action required.</br>
b) Persistent Work: For development/debugging, preserve data by: Creating a derived image with critical files, using Docker volumes for persistent storage or implementing regular backups.

## Contributing
- Fork the repository
- Create a feature branch
- Submit a pull request

## Licenses
Please read on ...
* https://www.debian.org
* https://mate-desktop.org
* https://github.com/moby/moby/blob/master/LICENSE
* https://docs.docker.com/subscription/desktop-license/
* For other software, please visit the respective web page.

## Contact
Mariano J. Lenkiewicz</br>
e-mail: [mariano.javier.lenkiewicz@gmail.com](mailto:mariano.javier.lenkiewicz@gmail.com)  
Project Link: [https://github.com/mjlenkiewicz/debian-mate](https://github.com/mjlenkiewicz/debian-mate)

## References
You can see some related cool stuff on ...</br>
https://www.youtube.com/@NetworkChuck</br>
https://www.youtube.com/@agiledevart</br>
https://www.youtube.com/@TechnoTim</br>
https://www.youtube.com/@Fireship</br>
