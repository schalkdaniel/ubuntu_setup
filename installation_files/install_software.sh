#!/bin/bash

# install linux-surface kernel (download .dev files first):
git clone https://github.com/jakeday/linux-surface.git ~/linux-surface
cd ~/linux-surface
sudo sh setup.sh
sudo dpkg -i linux-headers-[VERSION].deb linux-image-[VERSION].deb linux-libc-dev-[VERSION].deb

# install sublime text:
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -

sudo apt-get install apt-transport-https

echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list

sudo apt-get update
sudo apt-get install sublime-text

# install git:
sudo apt-get install git

# install tmux:
sudo apt-get install tmux

# bash-it:
git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it
~/.bash_it/install.sh

# powerline font:
sudo apt-get install fonts-powerline

# install powerline:
sudo apt-get install powerline

# Change theme in ~/.bashrc (hidden file): export BASH_IT_THEME='powerline-plain'

# install r:
sudo apt-get install r-base-core

# Sublime extenstion:
#   - SendCode
#   - R-Box
