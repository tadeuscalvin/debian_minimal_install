# Debian (ultra) minimal installation.
# I'd assume that you have installed the debian minimal 
# using netinstall
# Made by tadeuscalvin 
# https://github.com/tadeuscalvin

echo -e "\n"
echo -e "\n"
echo -e "\n"
echo "What is the name of your user (for non-root login)?"
read USER
HOME=/home/$USER
cd ~

# Here is the xorg most minimal install. Xorg-core is the xorg's nucleus,
# xinit allow you to access the user interface, xorg-video-intel
# is the video driver (remember to change it according to you case), and libinput 
# should be sufficient to manage your keyboard, mouse or touchpad.
echo -e "\n"
echo -e "\n"
echo -e "\n"
echo "We will begin installing the xorg."
echo -e "\n"
echo -e "\n"
echo -e "\n"
sleep 3
apt-get install xserver-xorg-core xinit xserver-xorg-video-intel xserver-xorg-input-libinput --no-install-recommends

# Install the window manager. I use i3, because of it's
# simplicity and minimalism. You can change it as you wish.
# The package i3status is the status bar of i3.
echo -e "\n"
echo -e "\n"
echo -e "\n"
echo "Now, let's install the i3 wm?"
echo -e "\n"
echo -e "\n"
echo -e "\n"
sleep 3
apt-get install i3-wm i3status --no-install-recommends

# We've to install some packages like a terminal emulator, web browser and sudo.
# pcmanfm is a lightweight file manager, feh set the wallpaper, 
# networkmanager and gnome-keyring are packages for networking.
# volumeicon displays an icon to control volume,
# git will allow to clone the configuration files from the github,
# if you like it.
echo -e "\n"
echo -e "\n"
echo -e "\n"
echo "You need will some packages to do something with this system"
echo -e "\n"
echo -e "\n"
echo -e "\n"
sleep 3
apt-get install sudo lxterminal pcmanfm feh firefox-esr parcellite git network-manager-gnome gnome-keyring alsamixer volumeicon-alsa --no-install-recommends

# To give you permission to use sudo:
echo "$USER ALL=(ALL:ALL) ALL" >> /etc/sudoers

# To have network-manager to manage the connections:
rm /etc/network/interfaces

# now let's clone the repository
# maybe you will prefer make your own repository with your 
# own config files, or even put it in a pendrive or whatever.
echo -e "\n"
echo -e "\n"
echo -e "\n"
echo "Now is time to clone the repository who contains the config files that you (might) need"
echo -e "\n"
echo -e "\n"
echo -e "\n"
sleep 3
git clone https://github.com/tadeuscalvin/debian_minimal_install

#verify if directory .i3 exists, and if doesn't, create it 
if [ ! -d ".i3" ]; then
	mkdir .i3
fi

# copy the config. file of i3 to you system
cp debian_minimal_install/config								.i3

# copy the config. file of status bar
cp debian_minimal_install/.i3status.conf						.

# This is a script for a randomly changing 
# wallpaper. A little useless, but cool
# It will assume that your images are in 
# ~/Images/Wallpaper, remember to adjust this!
cp debian_minimal_install/.random_wallpaper.sh					.

# The bashrc, you certainly know what is it, right?
cp debian_minimal_install/.bashrc								.

echo -e "\n"
echo -e "\n"
echo -e "\n"
echo "Now let's see if the system is up-to-date:"
echo -e "\n"
echo -e "\n"
echo -e "\n"
sleep 3
apt-get update && apt-get upgrade

# change owner of all the items of your home
echo -e "\n"
echo -e "\n"
echo -e "\n"
echo "Now let's change the owner of your home to you"
echo -e "\n"
echo -e "\n"
echo -e "\n"
sleep 3
chown $USER:$USER -Rv ~

echo -e "\n"
echo -e "\n"
echo -e "\n"
echo "Reboot now? y or n"
read a
if [ a == y ]; then
	reboot
fi
