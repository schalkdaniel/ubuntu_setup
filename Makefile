#
# Ubuntu 18.04 (Bionic Beaver)
#
# Author: Daniel Schalk
#
# Adapted from: https://gist.github.com/h4cc/c54d3944cb555f32ffdf25a5fa1f2602

.PHONY:	update upgrade preparations graphics google_chrome python slack latex sublime java tools rstudio bash-it docker jupyter

server: 
	@echo "Preparing server for data science!!!"
	make update
	make upgrade
	make preparations
	make graphics
	make cuda
	make R
	make python
	make tensorflow-keras
	make latex
	

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
	make tensorflow-keras
	make slack
	make latex
	make sublime
	make sublime-packages
	make jupyter
	make java
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
	# To get this work as expected replace the original keyboard shortcuts for 'Move to workspace above/below'
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
	# make bash-it
	sudo apt-get install fonts-powerline
	sudo apt-get install powerline
	sed -i 's/bobby/powerline-plain/' ~/.bashrc

graphics:
	sudo add-apt-repository ppa:graphics-drivers/ppa
	make update
	# sudo apt-get install nvidia-driver-396
	sudo ubuntu-drivers autoinstall

cuda:
	make graphics
	sudo apt-get install nvidia-cuda-toolkit
  # sudo dpkg -i cuda-repo-ubuntu1710_9.2.148-1_amd64.deb
  # sudo apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1710/x86_64/7fa2af80.pub
  # sudo apt-get update
  # sudo apt-get install cuda

google_chrome:
	rm -f google-chrome-stable_current_amd64.deb
	wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
	sudo apt -y install libappindicator1 libindicator7
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
	Rscript -e "install.packages(c('devtools', 'prettycode', 'Rcpp', 'RcppArmadillo'))"
	sudo ln -s -f ~/.R/library/Rcpp/include /usr/include/Rcpp
	sudo ln -s -f ~/.R/library/RcppArmadillo/include /usr/include/RcppArmadillo

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
	sudo apt-get install python-pip python-dev
	sudo apt-get install python3-dev
	sudo apt install python3-pip

# cudnn (https://medium.com/@taylordenouden/installing-tensorflow-gpu-on-ubuntu-18-04-89a142325138):
  # # Unpack the archive
  # tar -zxvf cudnn-9.0-linux-x64-v7.1.tgz 
  # # Move the unpacked contents to your CUDA directory
  # sudo cp -P cuda/lib64/libcudnn* /usr/local/cuda-9.0/lib64/
  # sudo cp  cuda/include/cudnn.h /usr/local/cuda-9.0/include/
  # # Give read access to all users
  # sudo chmod a+r /usr/local/cuda-9.0/include/cudnn.h /usr/local/cuda/lib64/libcudnn*

  # sudo apt-get install libcupti-dev

  # # Add to .bashrc:
  # export PATH=/usr/lib/cuda/bin${PATH:+:${PATH}}
  # export LD_LIBRARY_PATH=/usr/bin/cuda/lib64:${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}


tensorflow-keras:
	make cuda
	sudo pip3 install -U tensorflow-gpu  # Python 3.n
	pip3 install numpy scipy
	pip3 install scikit-learn
	pip3 install pillow
	pip3 install h5py
	pip3 install keras

slack:
	sudo snap install slack --classic

latex:
	sudo apt -y install pandoc pandoc-citeproc texlive-full dvipng nbibtex

sublime:
	wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
	sudo apt-add-repository "deb https://download.sublimetext.com/ apt/stable/"
	make update
	sudo apt -y install sublime-text
	subl
	ln -s -f ~/ubuntu_setup/dotfiles/'MyAddLineInBraces.sublime-macro' ~/.config/sublime-text-3/Packages/User/'MyAddLineInBraces.sublime-macro'
	ln -s -f ~/ubuntu_setup/dotfiles/'Default (Linux).sublime-keymap' ~/.config/sublime-text-3/Packages/User/'Default (Linux).sublime-keymap'
	ln -s -f ~/ubuntu_setup/dotfiles/'Preferences.sublime-settings' ~/.config/sublime-text-3/Packages/User/'Preferences.sublime-settings'

sublime-packages:
	git clone https://github.com/randy3k/SendCode.git ~/.config/sublime-text-3/Packages/SendCode
	git clone https://github.com/nfour/Sublime-Theme-Cola.git ~/.config/sublime-text-3/Packages/"Theme - Cola"
	sed -i 's/Default.sublime-theme/Cola.sublime-theme/' ~/ubuntu_setup/dotfiles/'Preferences.sublime-settings'
	# git clone https://github.com/randy3k/R-Box.git ~/.config/sublime-text-3/Packages/R-Box
	echo "- Install R-Box via package control"
	git clone https://github.com/niosus/EasyClangComplete.git ~/.config/sublime-text-3/Packages/EasyClangComplete
	sudo apt-get install clang
	clang++ --version
	ln -s -f ~/ubuntu_setup/dotfiles/'EasyClangComplete.sublime-settings' ~/.config/sublime-text-3/Packages/User/'EasyClangComplete.sublime-settings'
	git clone https://github.com/facelessuser/BracketHighlighter.git ~/.config/sublime-text-3/Packages/BracketHighlighter
	git clone git://github.com/jisaacks/GitGutter.git ~/.config/sublime-text-3/Packages/GitGutter

jupyter:
	sudo apt-get install jupyter-client
	sudo apt-get install jupyter-notebook
	Rscript -e "install.packages(c('repr', 'IRdisplay', 'evaluate', 'crayon', 'pbdZMQ', 'devtools', 'uuid', 'digest'))"
  Rscript -e "devtools::install_github('IRkernel/IRkernel')"
  Rcscipt -e "IRkernel::installspec()"
  pip3 install notedown

java:
	#FIXME: Do I need oracle jdk or is open enough?
	sudo apt -y install default-jre default-jdk

doxygen:
	sudo apt-get install doxygen
	sudo apt-get install graphviz

ssh-key:
	ssh-keygen -t rsa -b 4096 -C "d-schalk@t-online.de"
	ssh-add ubuntu_home_git
