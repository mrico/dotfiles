#!/bin/bash
# Script to bootstrap a new machine.

function install_local_bin {
  if [ ! -d "$HOME/bin" ]; then
    mkdir -p $HOME/bin
  fi
}

function install_apt_packages {
	sudo apt-get install -y curl tmux neovim ack-grep git exuberant-ctags
}

function install_vim_plug {
	local PLUG_FILE=~/.local/share/nvim/site/autoload/plug.vim
	if [ ! -e "$PLUG_FILE" ]; then
		curl -fLo $PLUG_FILE --create-dirs \
    			https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
		# Install neovim plugins and quit.
		nvim -c PlugInstall -c qa!
	fi
}

function install_tmux_plugin_manager {
	local TPM_HOME=~/.tmux/plugins/tpm
	if [ ! -d "$TPM_HOME" ]; then
		git clone https://github.com/tmux-plugins/tpm $TPM_HOME
	fi
}

function install_adobe_source_code_pro {
	# NOTE: The terminal font has to be changed manually!

	# ~/.fonts is now deprecated and that
	#FONT_HOME=~/.fonts
	# ~/.local/share/fonts should be used instead
	local FONT_HOME=~/.local/share/fonts
	local ADOBE_HOME="$FONT_HOME/adobe-fonts/source-code-pro"

	if [ -d "$ADOBE_HOME" ]; then
		echo "Font Source Code Pro already installed at $ADOBE_HOME"
		return	
	fi

	echo "installing fonts at $PWD to $FONT_HOME"
	mkdir -p "$ADOBE_HOME"

	(git clone \
	   --branch release \
	   --depth 1 \
	   'https://github.com/adobe-fonts/source-code-pro.git' \
	   "$FONT_HOME/adobe-fonts/source-code-pro" && \
	fc-cache -f -v "$FONT_HOME/adobe-fonts/source-code-pro")
}

function install_openjdk {
	sudo apt-get install -y openjdk-8-jdk-headless
}

function install_leiningen {
  local LEIN=$HOME/bin/lein
  if [ ! -e "$LEIN" ]; then
    curl -fLo $LEIN https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein
    chmod 750 $LEIN
  fi
}

function install_nodejs {
  which node > /dev/null
  if [ "$?" != 0 ]; then
    curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
    sudo apt-get install -y nodejs
  fi
}

function install_sbt {
  which sbt > /dev/null
  if [ "$?" != 0 ]; then
    echo "deb https://dl.bintray.com/sbt/debian /" | sudo tee /etc/apt/sources.list.d/sbt.list
    sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2EE0EA64E40A89B84B2DF73499E82A75642AC823
    sudo apt-get update
    sudo apt-get install sbt
  fi
}

function install_docker {
  which docker > /dev/null
  if [ "$?" != 0 ]; then
    echo "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list
    curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | sudo apt-key add -
    sudo apt-get update
    sudo apt-get install -y docker-ce
  fi
}

install_local_bin
#install_apt_packages
install_vim_plug
install_tmux_plugin_manager
install_adobe_source_code_pro
#install_openjdk
#install_leiningen
#install_nodejs
#install_sbt
#install_docker

