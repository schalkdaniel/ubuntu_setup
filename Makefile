#
# Ubuntu 18.04 (Bionic Beaver)
#
# Author: Daniel Schalk
#
# Adapted from: https://gist.github.com/h4cc/c54d3944cb555f32ffdf25a5fa1f2602

.PHONY:	update upgrade preparations graphics google_chrome python slack latex sublime java tools rstudio bash-it ssh-key docker

all:
	@echo "Installing everything!"
	make update
	make upgrade
	make preparations
	make tools
	make bash-it
	make powerline
	make graphics
	make google_chrome
	make R
	make rstudio
	make python
	make slack
	make latex
	make sublime
	make java
	make impressive
	make doxygen

update:
	sudo apt update

upgrade:
	sudo apt -y upgrade

preparations:
	make update
	sudo apt -y install software-properties-common build-essential checkinstall wget curl git libssl-dev apt-transport-https ca-certificates libcurl4-openssl-dev libxml2-dev libcairo2-dev libgmp3-dev libproj-dev libcgal-dev libglu1-mesa-dev libx11-dev libgsl-dev libcr-dev mpich mpich-doc

tools:
	sudo apt -y install ack tmux
	git clone https://github.com/gpakosz/.tmux.git ~/.tmux
	ln -s -f ~/.tmux/.tmux.conf ~/.tmux.conf
	cp ~/.tmux/.tmux.conf.local ~/.
	echo "\n# Customizations to shortcuts" >> ~/.tmux.conf.local
	echo "unbind <" >> ~/.tmux.conf.local
	echo "unbind _" >> ~/.tmux.conf.local
	echo "bind < split-window -h" >> ~/.tmux.conf.local
	echo "bind - split-window -v" >> ~/.tmux.conf.local
	echo "unbind '\"'" >> ~/.tmux.conf.local
	echo "unbind %" >> ~/.tmux.conf.local

bash-it:
	git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it
	~/.bash_it/install.sh

powerline:
	make bash-it
	sudo apt-get install fonts-powerline
	sudo apt-get install powerline
	sed -i 's/bobby/powerline-plain/' ~/.bashrc

graphics:
	sudo add-apt-repository ppa:graphics-drivers/ppa
	make update
	sudo apt install nvidia-396

google_chrome:
	rm -f google-chrome-stable_current_amd64.deb
	wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
	sudo apt -y install libappindicator1 libindicator7
	sudo dpkg -i google-chrome-stable_current_amd64.deb
	rm -f google-chrome-stable_current_amd64.deb

R:
	make preparations
	sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9
	sudo add-apt-repository 'deb [arch=amd64,i386] https://cran.rstudio.com/bin/linux/ubuntu bionic-cran35/'
	sudo apt -y install r-base r-base-dev
	mkdir -p ~/.R/library
	ln -s -f ~/ubuntu_setup/dotfiles/.Renviron ~/.Renviron
	ln -s -f ~/ubuntu_setup/dotfiles/.Rprofile ~/.Rprofile
	echo "$(<dotfiles/.bashrc_r )" >> ~/.bashrc
	Rscript -e "install.packages(c('devtools', 'prettycode'))"

rstudio:
	rm -f rstudio-xenial-1.1.447-amd64.deb
	wget https://download1.rstudio.org/rstudio-xenial-1.1.447-amd64.deb
	sudo apt -y install libjpeg62
	sudo dpkg -i rstudio-xenial-1.1.447-amd64.deb
	rm -f rstudio-xenial-1.1.447-amd64.deb

python:
	make preparations
	sudo -H apt -y install python-pip
	sudo -H pip install --upgrade pip

slack:
	sudo snap install slack --classic

latex:
	sudo apt -y install pandoc pandoc-citeproc texlive-full dvipng nbibtex

sublime:
	wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
	sudo apt-add-repository "deb https://download.sublimetext.com/ apt/stable/"
	make update
	sudo apt -y install sublime-text

java:
	#FIXME: Do I need oracle jdk or is open enough?
	sudo apt -y install default-jre default-jdk

impressive:
	sudo apt -y install python-opengl python-pygame python-pil
	wget https://sourceforge.net/projects/impressive/files/Impressive/0.12.0/Impressive-0.12.0.tar.gz
	sudo tar -xf Impressive-0.12.0.tar.gz -C /opt
	rm Impressive-0.12.0.tar.gz
	sudo ln -s /opt/Impressive-0.12.0/impressive.py /usr/bin/imp

ssh-key:
	ssh-keygen -t rsa -b 4096 -C "janek.thomas@web.de"
	ssh-add ~/.ssh/id_rsa


sublime-links:
	ln -fs ~/dotfiles/sublime/Preferences.sublime-settings ~/.config/sublime-text-3/Packages/User/Preferences.sublime-settings
	ln -fs ~/dotfiles/sublime/Default\ \(Linux\).sublime-keymap ~/.config/sublime-text-3/Packages/User/Default\ \(Linux\).sublime-keymap
	ln -fs ~/dotfiles/sublime/SendCode\ \(Linux\).sublime-settings ~/.config/sublime-text-3/Packages/SendCode/SendCode\ \(Linux\).sublime-settings

doxygen:
	sudo apt-get doxygen
	sudo apt-get graphviz
