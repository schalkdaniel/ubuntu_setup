#!/bin/bash

# install linux-surface kernel (download .dev files first):
# git clone https://github.com/jakeday/linux-surface.git ~/linux-surface
# cd ~/linux-surface
# sudo sh setup.sh
# sudo dpkg -i linux-headers-[VERSION].deb linux-image-[VERSION].deb linux-libc-dev-[VERSION].deb

## sublime text:
## -------------------------
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -

sudo apt-get install apt-transport-https

echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list

sudo apt-get update
sudo apt-get install sublime-text

## git:
## -------------------------

sudo apt-get install git

git config --global user.name "schalkdaniel"
git config --global user.email d-schalk@t-online.de

## tmux:
## -------------------------
sudo apt-get install tmux

# customize ubuntu by installing: https://github.com/gpakosz/.tmux
# Add:
# set -g mouse on 
# unbind <
# unbind _
# split panes using | and -
# bind < split-window -h
# bind - split-window -v
# unbind '"'
# unbind %


## bash-it:
## -------------------------
git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it
~/.bash_it/install.sh

## powerline font:
## -------------------------
sudo apt-get install fonts-powerline

## powerline:
## -------------------------
sudo apt-get install powerline

# Change theme in ~/.bashrc (hidden file): export BASH_IT_THEME='powerline-plain'

## pandoc:
## -------------------------
sudo apt-get install pandoc

## R:
## -------------------------
sudo apt-get install r-base-core
sudo apt-get install r-base-dev

sudo apt-get install build-essential libcurl4-gnutls-dev libxml2-dev libssl-dev # necessary for devtools

Rscript setup_files/r_packages.R

## texlive:
## -------------------------
sudo apt-get install texlive-full

## Doxygen:
## -------------------------
sudo apt-get doxygen
sudo apt-get graphviz



## Additional Stuff:
## -------------------------

# Sublime extenstion:
#   - SendCode
#   - R-Box
#   - Emmet
#   - LaTeXTools
#		- Theme: Cola
#   - Copy setup_files/MyAddLineInBraces.sublime-macro to ./home/.config/sublime-text3/Packages/User
#   - Key Bindings: setup_files/subl_key_binidngs.json T

# install own bash commands
# 1. copy bin folder of repository into home
# 2. make each bash file as an executeable
#
# - pbtex: pdflatex + bibtex + 2x pdflatex
sudo chmod +x ~/bin/pbtex



# Create shortcuts
