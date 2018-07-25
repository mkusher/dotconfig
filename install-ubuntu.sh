#!/usr/bin/env bash

apt update
apt upgrade
apt install zsh tmux
useradd -m --user-group mkusher
chsh -s /bin/zsh mkusher
usermod -a -G sudo mkusher
passwd mkusher
cp -R .ssh/ /home/mkusher/
rm .ssh/authorized_keys
chown -R mkusher:mkusher /home/mkusher/.ssh/
rm /home/mkusher/.bash*
add-apt-repository ppa:neovim-ppa/stable
curl -sL https://deb.nodesource.com/setup_8.x | bash -
add-apt-repository ppa:ondrej/php
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository \\
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \\
   $(lsb_release -cs) \\
   stable"
add-apt-repository ppa:cpick/hub
apt update
apt-get install \\
    nodejs php7.2 docker-ce neovim \\
    php7.2-curl php7.2-xml php7.2-bcmath php7.2-mbstring \\
    apt-transport-https \\
    ca-certificates \\
    curl \\
    software-properties-common \\
    hub
usermod -a -G docker mkusher
pip install docker-compose
su mkusher
ssh-keygen
exit
