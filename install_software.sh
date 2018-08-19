#!/bin/bash

# install linux-surface kernel (download .dev files first):
# git clone https://github.com/jakeday/linux-surface.git ~/linux-surface
# cd ~/linux-surface
# sudo sh setup.sh
# sudo dpkg -i linux-headers-[VERSION].deb linux-image-[VERSION].deb linux-libc-dev-[VERSION].deb


## git:
## -------------------------

sudo apt-get install git

git config --global user.name "schalkdaniel"
git config --global user.email d-schalk@t-online.de



## Additional Stuff:
## -------------------------

# Sublime extenstion:
#   - R-Box
#   - Emmet
#   - LaTeXTools

# install own bash commands
# 1. copy bin folder of repository into home
# 2. make each bash file as an executeable
#
# - pbtex: pdflatex + bibtex + 2x pdflatex
sudo chmod +x ~/bin/pbtex



# Create shortcuts
