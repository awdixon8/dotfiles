.PHONY: installatom
installatom: ## Install atom and atom packages
		sudo wget -qO - https://packagecloud.io/AtomEditor/atom/gpgkey | sudo apt-key add -
		sudo sh -c 'echo "deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main" > /etc/apt/sources.list.d/atom.list'
		sudo apt update
		sudo apt install atom -y
		apm install minimap atom-beautify file-icons language-terraform python-isort python-yapf atom-python-virtualenv
.PHONY: installtmux
installtmux: ## Install tmux
		sudo apt install tmux -y
