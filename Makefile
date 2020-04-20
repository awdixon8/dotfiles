#################
### All ###
#################

.PHONY: all
all: installgit installtmux installzsh installneovim pythonenvs dotfiles installatom installvscode installvlc

##########################
### Terminal/dev setup ###
##########################

.PHONY: installgit ## Install git
installgit:
	sudo apt install git -y

.PHONY: installtmux
installtmux: ## Install tmux
	sudo apt install tmux -y

.PHONY: installzsh
installzsh: ## Install zsh and oh-my-zsh
	sudo apt install zsh -y
	sh -c "$$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	chsh -s /usr/bin/zsh

.PHONY: installneovim
installneovim: ## Install neovim
	sudo apt install neovim -y

.PHONY: pythonenvs
pythonenvs: ## Install and create virtual python environments
	sudo apt install python-pip -y
	sudo apt install python3-pip -y
	mkdir -p $$HOME/environments
	pip install virtualenv
	python -m virtualenv $$HOME/environments/pyenv2
	pip3 install virtualenv
	python3 -m virtualenv $$HOME/environments/pyenv3

.PHONY: dotfiles
dotfiles: ## Installs the dotfiles.
	# add aliases for dotfiles
	for file in $(shell find $(CURDIR) -name ".*" -not -name ".gitignore" -not -name ".travis.yml" -not -name ".git" -not -name ".*.swp" -not -name ".gnupg"); do \
		f=$$(basename $$file); \
		ln -sfn $$file $(HOME)/$$f; \
	done; \

##############################
### Text editors and IDE's ###
##############################

.PHONY: installatom
installatom: ## Install atom and atom packages
	sudo wget -qO - https://packagecloud.io/AtomEditor/atom/gpgkey | sudo apt-key add -
	sudo sh -c 'echo "deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main" > /etc/apt/sources.list.d/atom.list'
	sudo apt update
	sudo apt install atom -y
	apm install minimap atom-beautify file-icons language-terraform python-isort atom-python-virtualenv
	cp --force config.cson ~/.atom/config.cson

.PHONY: installvscode
installvscode: ## Install vscode and plugins
	curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
	sudo install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/
	sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

############
### MISC ###
############

.PHONY: installfirefoxplugins
installfirefoxplugins: ## Install the usual firefox plugins
	sudo wget https://addons.mozilla.org/firefox/downloads/file/1717871/lastpass_password_manager-4.26.0.4-fx.xpi?src=collection
	mv lastpass_password_manager-4.26.0.4-fx.xpi\?src\=collection lastpass_password_manager-4.26.0.4-fx.xpi
	firefox lastpass_password_manager-4.26.0.4-fx.xpi

.PHONY: installvlc
installvlc: ## Install vlc
	sudo apt install vlc -y

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
