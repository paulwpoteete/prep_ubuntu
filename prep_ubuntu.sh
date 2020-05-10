#!/bin/bash
# 20200509_PWP
# Configure an Ubuntu 20.04 RPi 3 for Production use
clear
printf "\n\nThis script will autoconfigure a RPi 3 for production use.\n"
echo "These options are entirely based on my opinion, and may or may not be suitable for your particular needs."
echo "(This process will remove netplan and snapd)"
echo -e "\033[4mThere is no warranty of any kind.\033[0m"
echo '
Copyright 2020 Paul W. Poteete

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
'
printf "\n\n\nIf you wish to continue, type the lowercase letter y and press enter: "
read var_agree
if [ $var_agree != 'y' ]
then
	echo -e "\n\033[1m\e[91mConfiguration Cancelled.\033[0m\n"
	exit 0
fi
echo -e "\n\n\n\033[1m\e[92mWell then... Let's get started!!!\033[0m\n\n"
sleep 1
echo -e "\n\033[1mUpdating system...\033[0m"
apt-get update
echo -e "\n\033[1mInstalling base tools...\033[0m"
apt-get install --install-recommends -y network-manager ifupdown net-tools cryptsetup exfat-utils glusterfs* rsync xz-utils cifs-utils john iperf vim
echo -e "\n\033[1mRemoving abominations (snapd and netplan)...\033[0m"
apt-get remove --purge -y snapd
apt-get remove --purge -y netplan.io
rm -rf /usr/share/netplan /etc/netplan /etc/cloud
echo -e "\n\033[1mBacking up and Replacing configuration files...\033[0m"
for file in 'vim/vimrc sudoers resolv.conf network/interfaces NetworkManager.conf motd'
do
	cd /etc
	mv -v /etc/$file /etc/$file.original
	wget -O - http://public.cybernados.net/pub/prep_ubuntu/ubuntu_configs.tar | tar xv
	chown 0 /etc/$file
done
chown 0:0 /etc/sudoers
chmod 660 /etc/sudoers

echo -e "\n\033[1mUpdating the bash prompt...\033[0m"
wget -O /root/.bashrc http://public.cybernados.net/pub/prep_ubuntu/bashrc
wget -O /home/ubuntu/.bashrc http://public.cybernados.net/pub/prep_ubuntu/bashrc
mv -v /etc/update-motd/10-help* /root/
printf "\n\nConfiguration Complete.\nThe new IP address upon reboot will be 192.168.1.199\nIf you wish to change this, edit the /etc/network/interfaces file now...\n\n"
exit 0
