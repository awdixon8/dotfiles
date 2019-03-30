.PHONY: installatom
installatom: ## Install atom and atom packages
	sudo wget -qO - https://packagecloud.io/AtomEditor/atom/gpgkey | sudo apt-key add -
	sudo sh -c 'echo "deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main" > /etc/apt/sources.list.d/atom.list'
	sudo apt update
	sudo apt install atom -y
	apm install minimap atom-beautify file-icons language-terraform python-isort python-yapf atom-python-virtualenv
	cp --force config.cson ~/.atom/config.cson

.PHONY: installtmux
installtmux: ## Install tmux
		sudo apt install tmux -y

.PHONY: dotfiles
dotfiles: ## Installs the dotfiles.
	# add aliases for dotfiles
	for file in $(shell find $(CURDIR) -name ".*" -not -name ".gitignore" -not -name ".travis.yml" -not -name ".git" -not -name ".*.swp" -not -name ".gnupg"); do \
		f=$$(basename $$file); \
		ln -sfn $$file $(HOME)/$$f; \
	done; \
	
.PHONY: installneovim
installneovim: ## Install neovim
		sudo apt install neovim -y

.PHONY: installfirefoxplugins
installfirefoxplugins: ## Install the usual firefox plugins
		sudo wget https://addons.mozilla.org/firefox/downloads/file/1717871/lastpass_password_manager-4.26.0.4-fx.xpi?src=collection
		mv lastpass_password_manager-4.26.0.4-fx.xpi\?src\=collection lastpass_password_manager-4.26.0.4-fx.xpi
		firefox lastpass_password_manager-4.26.0.4-fx.xpi

.PHONY: installvlc
installvlc: ## Install vlc
		sudo apt install vlc -y

.PHONY: pythonenvs
pythonenvs: ## Install and create virtual python environments
		sudo apt install python-pip -y
		sudo apt install python3-pip -y
		mkdir -p $$HOME/environments
		pip install virtualenv
		python -m virtualenv $$HOME/environments/pyenv2
		pip3 install virtualenv
		python3 -m virtualenv $$HOME/environments/pyenv3
