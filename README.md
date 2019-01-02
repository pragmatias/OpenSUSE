# OpenSUSE Tumbleweed

Here, you will find some scripts and config files for [OpenSUSE Tumbleweed](https://www.opensuse.org/#Tumbleweed).

All the work is based on the following ressources :
 - [blog.microlinux.fr](https://blog.microlinux.fr) *([OpenSUSE](https://blog.microlinux.fr/tag/opensuse/))*
 - [www.volted.net](https://www.volted.net/) *([ZSH](un-prompt-zsh-au-poil18555.html)/[VIM](https://www.volted.net/un-vimrc-remis-au-propre18752.html))*
 - [denisrosenkranz.com](http://denisrosenkranz.com/installation-et-configuration-de-zsh/) *([ZSH](http://denisrosenkranz.com/installation-et-configuration-de-zsh/))*

 
## Requirement
 1. Install [OpenSUSE Tumbleweed](https://software.opensuse.org/distributions/tumbleweed) with the [KDE/Plasma Desktop](https://www.kde.org/plasma-desktop)
 2. Install [GIT](https://git-scm.com/) : `sudo zypper in --no-recommend git`
 3. Get this git [repository](https://github.com/pragmatias/opensuse) : `git clone https://github.com/pragmatias/OpenSUSE.git ~/tmp_install`
 4. Go to the scripts folder : `cd ~/tmp_install/scripts`

>  **Proxy** : somes information if you want to install OpenSUSE Tumbleweed behind a proxy
> ##### With Yast
> 1. Open Yast > Network Services > Proxy
> 2. Click on Enable Proxy and fill all the needed information in "Proxy Setting" and "Proxy Authentification"
> ##### With Bashrc
 > 1. Add http information : `echo "export http_proxy=http://proxy_ip:proxy_port" >> ~/.bashrc`
 > 2. Add https information : `echo "export https_proxy=http://proxy_ip:proxy_port" >> ~/.bashrc`
 > 3. Add no proxy information : `echo "export no_proxy=localhost,127.0.0.1" >> ~/.bashrc`
 > 4. Add ftp information : `echo "export ftp_proxy=http://proxy_ip:proxy_port" >> ~/.bashrc`

 
## Steps
 1. Configure the repositories list : `sudo ./01_TW_config_repository.sh`
> *Note* : you need to remove the nvidia repository if you don't have a nvidia graphic card
 2. Remove the listed packages : `sudo ./02_TW_remove_package.sh`
 3. Install the listed packages : `sudo ./03_TW_install_package.sh`
> *Note* : if the "vlc-codecs" installation isn't [OK], you need to install it manually with the command `sudo zypper in --no-recommend vlc-codecs` and choose options with vendor change for the libraries
 4. Install of truetype proprietary fonts : `sudo ./04_TW_install_fonts_truetype.sh`
 5. Customization of users : `sudo ./05_TW_customize_users.sh` 
 6. Install the graphic card driver (manually) : `sudo zypper in --no-recommend nvidia-glG05`
 7. Restart your computer : `sudo shutdown -r 0`
 8. Remove the tmp_install folder : `rm -rf ~/tmp_install`

 
# Customization of OpenSUSE Tumbleweed (KDE/Plasma Desktop)
- Prerequisite : 
	- Install of the [SierraBreeze](https://github.com/ishovkun/SierraBreeze) Window decoration :
		- 1. `sudo zypper addrepo https://download.opensuse.org/repositories/home:trmdi/openSUSE_Tumbleweed/home:trmdi.repo`
		-  2. `sudo zypper refresh`
		-  3. `sudo zypper install sierra-breeze`


- KDE System (System settings)
	-	Workspace Theme > Look And Feel > Breeze Dark
	-	Workspace Theme > Desktop Theme > Breeze Dark
	-	Splash Screen > openSUSE
	-   Icons > Icons > Papirus-Dark
	-	Fonts > Fonts > Ubuntu (Hack for "Fixed  width")
	-	Application Style > Window Decorations > Sierra-breeze (with "Tiny" border size)
	-	Desktop Behavior > Workspace > Click behavior > Double-click to open files and folders
	-	Desktop Behavior > Screen Locking > deactivation Lock screen automatically
	-	Input Devices > Keyboard > NumLock on Plasma Startup > Turn on


- KDE Desktop
	- 	Right click on KDE dock > Panek Options >  Configure Panel >  More Settings > Remove Panel
	-	launch "latte-dock" > Choose the layout "users"

Todo :
 - [ ] Color of Konsole
 - [ ] KSH by default for Konsole
 - [ ] Configuration of Firefox


# Usefull Information about OpenSUSE Tumbleweed
### Zypper
 1. Install a package : ` sudo zypper in --no-recommend package`
 2. Remove a package : ` sudo zypper rm --clean-deprs package`
 3. Refresh repositories : `sudo zypper ref` or `sudo zypper ref -f`
 4. Update packages : `sudo zypper up`
 5. Search packages : `sudo zypper se package` or `sudo zypper se -is package`
> Note: replace **package** by the package name

### btrfs issue
If btrfs-cleaner use 100% of your CPU and freeze your computer, you can stop it with the following command :
`sudo btrfs quota disable /`

### Restart sound service (Pulseaudio)
`pulseaudio -k`

### Restart network service 
` sudo rcnetwork restart network_interface`
> Note: replace **network_interface** by your interface name (using ifconfig)

### Configuration the NFS client
 - Discover the shared volumes on the NFS server : ` showmount -e <ip>`
 - Mount a shared volume from the NFS server (manually) : `sudo mount -t nfs <ip>:<repnfs> <replocal>`
 - Mount a shared volume from the NFS server (automatically) : `sudo vi /etc/fstab` and add the line `<ip>:<repnfs> <replocal> nfs defaults 0 0`
> - **ip** of the NFS server
> - **repnfs** : path/folder on the NFS server
> - **replocal** : path/folder on the NFS client

### Autostart (KDE)
Copy a file **org.kde.*.desktop** in the folder **~/.config/autostart**
> You could find them in the folder */usr/share/applications*

### Reset KDE Session
To reset the current KDE session (killing all process & logout) : `pkill -kill -u username`
> Note : replace **username** by the name of the choosen one
