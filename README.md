<h1 align="center">Work in progress</h1>

Add Leap VM configuration (Virtual Machine) with a minimal install & I3-gaps
Modify Tumbleweed configuration with KDE default install & I3-gaps
Modify Yast/Zypper conf with "--no-recommends"

<h1 align="center">OpenSUSE Tumbleweed</h1>

Here, you will find some scripts and config files for [OpenSUSE Tumbleweed](https://www.opensuse.org/#Tumbleweed).

1. [Install](#Install)
2. [Customization](#Customization)
3. [Tips](#Tips)

<h2 align="center">Introduction</h2>

All the work is based on the following resources :

 - [blog.microlinux.fr](https://blog.microlinux.fr) *([OpenSUSE](https://blog.microlinux.fr/tag/opensuse/))*
 - [www.volted.net](https://www.volted.net/) *([ZSH](un-prompt-zsh-au-poil18555.html)/[VIM](https://www.volted.net/un-vimrc-remis-au-propre18752.html))*
 - [denisrosenkranz.com](http://denisrosenkranz.com/installation-et-configuration-de-zsh/) *([ZSH](http://denisrosenkranz.com/installation-et-configuration-de-zsh/))*
 - [KDE Tips](https://zren.github.io/kde/#configuration)
 
### Todo List
- [ ] Find a way to move windows with more position than "Quick Tile"
- [ ] Install & Use KDE Connect
- [ ] Learn how to use "KDE Activities"

### Things to do manually after install
 - Firefox Config (bookmarks)
 - Thunderbird Config (account)
 - NFS Config (NAS)
 - KeepassXC Config (file)
 - Add "Redshift Widget" in Latte-Dock (before System Tray)

<div id="Install">
<h2 align="center"> Install </h2>

### Requirement
 1. Install [OpenSUSE Tumbleweed](https://software.opensuse.org/distributions/tumbleweed) with the [KDE/Plasma Desktop](https://www.kde.org/plasma-desktop)
 2. Install [GIT](https://git-scm.com/) : `sudo zypper in --no-recommends git`
 3. Get this git [repository](https://github.com/pragmatias/OpenSUSE) : `git clone https://github.com/pragmatias/OpenSUSE.git ~/tmp_install`
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

<h3 align="left"> Steps </h3>

 1. Configure the repositories list : `sudo ./01_TW_config_repository.sh`
> *Note* : you need to remove the nvidia repository if you don't have a nvidia graphic card
 2. Remove the listed packages : `sudo ./02_TW_remove_package.sh`
 3. Install the listed packages : `sudo ./03_TW_install_package.sh`
> *Note* : if the "vlc-codecs" installation isn't [OK], you need to install it manually with the command `sudo zypper in --no-recommend vlc-codecs` and choose options with vendor change for the libraries
 4. Install of truetype proprietary fonts : `sudo ./04_TW_install_fonts_truetype.sh`
 5. Customization of users : `sudo ./05_TW_customize_users.sh` 
 6. Install the graphic card driver (manually) : `sudo zypper in nvidia-glG05`
 7. Restart your computer : `sudo shutdown -r 0`
 8. Remove the tmp_install folder : `rm -rf ~/tmp_install`

</div>

<div id="Customization">
<h2 align="center"> Customization of OpenSUSE Tumbleweed (KDE/Plasma Desktop) </h2>

* KDE System (System settings)
	*	Workspace Theme > Look And Feel > Breeze Dark
	*	Workspace Theme > Desktop Theme > Breeze Dark
	*	Splash Screen > openSUSE
	*   Icons > Icons > Papirus-Dark
	*	Fonts > Fonts > Ubuntu (Hack for "Fixed  width")
	*	Application Style > Window Decorations > Border size : No Borders
	*	Application Style > Window Decorations > Breeze (Customize : "Small" Button Size, check only "Draw window background gradient")
	*	Desktop Behavior > Workspace > Click behavior > Double-click to open files and folders
	*	Desktop Behavior > Screen Locking > deactivation Lock screen automatically
	*	Desltop Behavior > Virtual Desktop > Desktop (Customize : Number of desktops = 4 and Number of rows = 1)
	*	Input Devices > Keyboard > NumLock on Plasma Startup > Turn on
* KDE Desktop
    * Right Click on the desktop wallpaper > Configure Desktop > Tweask > Uncheck Show the desktop toolbox
    * Right Click on the desktop wallpaper > Configure Desktop > Filter > Show Files Matching
    * Right Click on the desktop wallpaper > Configure Desktop > Wallpaper > Add Image > Choose your wallpaper
</div>

<div id="Tips">
<h2 align="center"> Usefull Information about OpenSUSE Tumbleweed </h2>

### Zypper
 1. Install a package : ` sudo zypper in --no-recommend package`
 2. Remove a package : ` sudo zypper rm --clean-deps package`
 3. Refresh repositories : `sudo zypper ref` or `sudo zypper ref -f`
 4. Update packages : `sudo zypper up`
 5. Upgrade Distribution : `sudo zypper dup`
 6. Search packages : `sudo zypper se package` or `sudo zypper se -is package`
> Note: replace **package** by the package name

### btrfs issue
If btrfs-cleaner use 100% of your CPU and freeze your computer, you can stop it with the following command :
`sudo btrfs quota disable /`

### Restart sound service (Pulseaudio)
`pulseaudio -k`

### Restart network service 
` sudo rcnetwork restart network_interface`
> Note: replace **network_interface** by your interface name (using ifconfig)

### Configuration Fstab (with ntfs drive)
For each drive :
 1. Create the following folder : `mkdir /mnt/<name>`
 2. change the folder owner : `chown anybody:wheel /mnt/<name>` 
 3. update the fstab file `sudo vi /etc/fstab` with the following line : `/dev/<drive>          /mnt/<name>          ntfs     rw,nosuid,nodev,relatime   0  0` 

Tips :
 - list partitions : `sudo fdisk -l`
 - list block devices : ` lsblk`
 - list uuid : `sudo blkid`


### Configuration the NFS client
 - Discover the shared volumes on the NFS server : ` showmount -e <ip>`
 - Mount a shared volume from the NFS server (manually) : `sudo mount -t nfs <ip>:<repnfs> <replocal>`
 - Mount a shared volume from the NFS server (automatically) : `sudo vi /etc/fstab` and add the line `<ip>:<repnfs> <replocal> nfs rw,noauto,_netdev 0 0`
 - Mount all the fstab (reload) : `mount -a`
> - **ip** of the NFS server
> - **repnfs** : path/folder on the NFS server
> - **replocal** : path/folder on the NFS client


### Configure Bind to Switch Desktop and Quick tile Window
1. Go to System Settings > Shortcuts > Global Shortcuts > System Settings or Kwin
>| Action | Global |
>|--|--|
>| Quick Tile Window to the Bottom | Meta+Num+2 |
>| Quick Tile Window to the Bottom Left | Meta+Num+1 |
>| Quick Tile Window to the Bottom Right | Meta+Num+3 |
>| Quick Tile Window to the Left | Meta+Num+4 |
>| Quick Tile Window to the Right | Meta+Num+6 |
>| Quick Tile Window to the Top | Meta+Num+8 |
>| Quick Tile Window to the Top Left | Meta+Num+7 |
>| Quick Tile Window to the Top Right | Meta+Num+9 |
>| Switch One Desktop Down | Meta+Down |
>| Switch One Desktop to the Left | Meta+Left |
>| Switch One Desktop to the Right | Meta+Right |
>| Switch One Desktop Up | Meta+Up |
>| Full screen Window | Meta+f |
2. Right Click on the desktop wallpaper > Configure Desktop > Mouse Actions > Remove action "Switch Desktop" for "Vertical-Scroll"


### Autostart (KDE)
Copy a file **org.kde.*.desktop** in the folder **~/.config/autostart**
> You could find them in the folder */usr/share/applications*

Or use System Settings > Startup and Shutdown > Autostart

### Reset KDE Session
Reset the current KDE session (kill all process & logout) : `pkill -kill -u username`
> Note : replace **username** by the name of the choosen one


### Konsole configuration
In Settings > Edit Current Profile
1. General > Profile name > Users
2. General > Command > /bin/bash
3. Appearance > Color Scheme & Background > Monokai-Flat
4. Keyboard > Linux console


### Firefox configuration
The file **places.sqlite** in **$HOME/.mozilla/firefox/%.default** contains bookmarks and history

> List of interesting addons :
> - Ublock Origin
> - HTTPS Everywhere
> - Canvasblocker
> - Cookie autodelete
> - Css exfil protection
> - DecentralEyes
> - Redirector
> - Select context search
> - Awesome RSS
> - Privacy Badger
> - No Coin


### Latte Dock
List of widgets :
- Application Menu
- Pager
- Justify Splitter
- Latte plasmoid
- Justify Splitter
- System Tray
- Digital Clock
- Lock/Logout

> You need to download and add manually the widget "redshift"


To restore plasma config (panel) :
 1. `kquitapp plasmashell`
 2. `sleep 10s`
 3. `cp <plasma_files_backup> $HOME/.config/.`
 4. `plasmashell &`


### WMware tips
[Shared Folder](https://en.opensuse.org/SDB:VMware_Tools) :
- Listing of shared folder : `vmware-hgfsclient`
- Mount a shared folder : `vmhgfs-fuse -o allow_other .host: /mnt/`
- Unmount a shared folder : `fusermount -uz /mnt/`or `umount -f /mnt/`


### VirtualBox tips

Install VBoxGuestAdditions :
 1. insert file VBoxGuestAdditions*.iso in the cdrom
 2. `sudo mkdir -p /media/cdrom`
 3. `sudo mount -t iso9660 /dev/cdrom /media/cdrom`
 4. `cd /media/cdrom`
 5. `sudo ./VBoxLinuxAdditions.run`

Install VirtualBox package :
 1. `sudo zypper in virtualbox-guest-tools virtualbox-guest-x11`


### purge tmp folder

 1. copy the configuration file tmp.conf : `cp /usr/lib/tmpfiles.d/tmp.conf /etc/tmpfiles.d/tmp.conf`
 2. modify the line `q /tmp 1777 root root -` by `q /tmp 1777 root root 1d -`
 3. modify the line `q /var/tmp 1777 root root -` by `q /var/tmp 1777 root root 7d -`


### Install Notion

 1. `sudo zypper addrepo --refresh https://download.opensuse.org/repositories/system:/snappy/openSUSE_Tumbleweed snappy`
 2. `sudo zypper --gpg-auto-import-keys refresh`
 3. `sudo zypper dup --from snappy`
 4. `sudo zypper install snapd`
 5. `sudo systemctl enable snapd`
 6. `sudo systemctl start snapd`
 7. `sudo systemctl enable snapd.apparmor`
 8. `sudo systemctl start snapd.apparmor`
 9. `sudo snap install notion-snap`

</div>


