.PHONY: 1password all c cli configs editorconfig flatpak fonts git go gui help javascript kitty languages lua nvim packages python rpmfusion tmux upgrade zig zsh

HOME_BIN = $(HOME)/.local/bin
HOME_SHARE = $(HOME)/.local/share

GOPATH = $(HOME)/Go
NPM_PACKAGES ?= $(HOME)/.npm-packages

BUN = $(HOME)/.bun/bin/bun
CCLS = $(HOME_BIN)/ccls
DENO = $(HOME)/.deno/bin/deno
GOLINT = $(GOPATH)/bin/golangci-lint
GOLS = $(GOPATH)/bin/gopls
LUALS = $(HOME_BIN)/lua-language-server
PYLS = $(HOME_BIN)/pylsp
TSLS = $(NPM_PACKAGES)/bin/typescript-language-server
ZIGLS = $(HOME_BIN)/zls

$(shell mkdir -p $(HOME_BIN) $(HOME_SHARE))

help:
	@echo "      d8b                    ,d8888b d8,  d8b"
	@echo "      88P            d8P     88P'   '8P   88P"
	@echo "     d88          d888888Pd888888P       d88"
	@echo " d888888   d8888b   ?88'    ?88'     88b 888   d8888b .d888b,"
	@echo "d8P' ?88  d8P' ?88  88P     88P      88P ?88  d8b_,dP ?8b,"
	@echo "88b  ,88b 88b  d88  88b    d88      d88   88b 88b       '?8b"
	@echo "'?88P''88b'?8888P'  '?8b  d88'     d88'    88b'?888P''?888P'"
	@echo "-------------------------------------------------------------"
	@echo "        Install packages for any of the targets below"
	@echo "         or install them all using 'make packages':"
	@echo ""
	@echo "                 upgrade  rpmfusion  cli  gui"
	@echo "                  flatpak  1password  docker"
	@echo "-------------------------------------------------------------"
	@echo "         Set up configs for any of the targets below"
	@echo "          or install them all using 'make configs':"
	@echo ""
	@echo "                   editorconfig  fonts  git"
	@echo "                    kitty  nvim  tmux  zsh"
	@echo "-------------------------------------------------------------"
	@echo "    Set up language servers for any of the targets below"
	@echo "         or install them all using 'make languages':"
	@echo ""
	@echo "             c  go  javascript  lua  python  zig"
	@echo "-------------------------------------------------------------"
	@echo "                   Or just run 'make all'"

all: packages configs languages

packages: upgrade rpmfusion cli gui flatpak 1password docker

configs: editorconfig fonts git kitty nvim tmux zsh

languages: c go javascript lua python zig

editorconfig: cli $(HOME)/.editorconfig
$(HOME)/.editorconfig:
	stow -t $(HOME) editorconfig

fonts: cli $(HOME_SHARE)/fonts/Inter.ttc $(HOME_SHARE)/fonts/MonaspiceNeNerdFontMono-Regular.otf
$(HOME_SHARE)/fonts/Inter.ttc:
	mkdir -p $(HOME_SHARE)/fonts
	curl -fsSL https://github.com/rsms/inter/releases/download/v4.0/Inter-4.0.zip > /tmp/Inter.zip
	unzip /tmp/Inter.zip -d /tmp/Inter
	mv /tmp/Inter/*.ttf /tmp/Inter/*.ttc $(HOME_SHARE)/fonts
	rm -rf /tmp/Inter.zip /tmp/Inter
	fc-cache -f
$(HOME_SHARE)/fonts/MonaspiceNeNerdFontMono-Regular.otf:
	mkdir -p $(HOME_SHARE)/fonts
	curl -fsSL https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/Monaspace.zip > /tmp/Monaspace.zip
	unzip /tmp/Monaspace.zip -d /tmp/Monaspace
	mv /tmp/Monaspace/*.otf $(HOME_SHARE)/fonts
	rm -rf /tmp/Monaspace.zip /tmp/Monaspace
	fc-cache -f

git: cli $(HOME)/.gitconfig
$(HOME)/.gitconfig:
	stow -t $(HOME) git

kitty: cli $(HOME)/.config/kitty/kitty.conf
$(HOME)/.config/kitty/kitty.conf:
	stow -t $(HOME) kitty

nvim: cli $(HOME)/.config/nvim/init.lua
$(HOME)/.config/nvim/init.lua:
	stow -t $(HOME) nvim
	mkdir -p $(HOME_SHARE)/nvim/site/pack/paqs/start
	git clone --depth=1 https://github.com/savq/paq-nvim.git $(HOME_SHARE)/nvim/site/pack/paqs/start/paq-nvim
	nvim --headless -c "autocmd User PaqDoneInstall ++once quit" +PaqInstall

tmux: cli $(HOME)/.tmux.conf
$(HOME)/.tmux.conf:
	stow -t $(HOME) tmux
	git clone https://github.com/tmux-plugins/tpm $(HOME)/.tmux/plugins/tpm
	$(HOME)/.tmux/plugins/tpm/bin/install_plugins

zsh: cli $(HOME)/.zshrc
$(HOME)/.zshrc:
	stow -t $(HOME) zsh
	curl -fsSL https://starship.rs/install.sh > /tmp/starship_install.sh
	sh /tmp/starship_install.sh --yes
	rm -f /tmp/starship_install.sh
	mkdir -p $(HOME)/.zfunc
	chsh -s $$(command -v zsh) $$USER

c: cli $(CCLS)
$(CCLS):
	git clone --depth=1 --recursive https://github.com/MaskRay/ccls $(HOME_SHARE)/ccls
	cd $(HOME_SHARE)/ccls; \
		cmake -GNinja -H. -BRelease; \
		cmake --build Release
	echo '#!/bin/sh' > $(CCLS)
	echo 'exec "$(HOME_SHARE)/ccls/Release/ccls" "$$@"' >> $(CCLS)
	chmod a+x $(CCLS)

go: cli $(GOLS) $(GOLINT)
$(GOLS):
	go install golang.org/x/tools/gopls@latest
$(GOLINT):
	go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest

javascript: cli $(DENO) $(BUN) $(TSLS)
$(TSLS):
	sudo npm i -g npm
	npm config set prefix $(NPM_PACKAGES)
	npm i -g yarn typescript typescript-language-server
$(DENO):
	curl -fsSL https://deno.land/install.sh | sh
$(BUN):
	curl -fsSL https://bun.sh/install | sh

lua: $(LUALS)
$(LUALS):
	curl -fsSL https://github.com/LuaLS/lua-language-server/releases/download/3.7.4/lua-language-server-3.7.4-linux-x64.tar.gz > /tmp/lua-ls.tar.gz
	mkdir -p $(HOME_SHARE)/lua-ls
	cd $(HOME_SHARE)/lua-ls; \
		tar -xf /tmp/lua-ls.tar.gz
	echo '#!/bin/sh' > $(LUALS)
	echo 'exec "$(HOME_SHARE)/lua-ls/bin/lua-language-server" "$$@"' >> $(LUALS)
	chmod a+x $(LUALS)
	rm -f /tmp/lua-ls.tar.gz

python: cli $(PYLS)
$(PYLS):
	pipx install python-lsp-server
	pipx install mypy
	pipx install ruff
	pipx install ruff-lsp
	pipx inject python-lsp-server mypy

zig: $(ZIGLS)
$(ZIGLS):
	curl -fsSL https://zigtools-releases.nyc3.digitaloceanspaces.com/zls/master/x86_64-linux/zls > $(ZIGLS)
	chmod a+x $(ZIGLS)

upgrade: .installed-upgrade
.installed-upgrade:
	sudo rm -f /etc/yum.repos.d/_copr:copr.fedorainfracloud.org:phracer:PyCharm.repo
	sudo rm -f /etc/yum.repos.d/google-chrome.repo
	sudo dnf remove -y \
		libreoffice* gnome-maps gnome-contacts cheese gnome-terminal gnome-calendar \
		gnome-calculator gnome-tour gnome-weather gnome-clocks gnome-boxes
	sudo dnf upgrade --refresh -y
	touch .installed-upgrade

rpmfusion: upgrade .installed-rpmfusion
.installed-rpmfusion:
	sudo dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(shell rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(shell rpm -E %fedora).noarch.rpm
	touch .installed-rpmfusion

cli: rpmfusion .installed-cli
.installed-cli:
	sudo dnf install -y \
		autoconf automake bat byacc cargo clang clang-devel cmake curl fd-find \
		g++ gcc git go llvm llvm-devel neovim ninja-build nodejs npm pip python \
		python-devel rust stow the_silver_searcher tmux unrar unzip pipx wget \
		util-linux-user zig zsh htop neofetch poetry sqlite3
	touch .installed-cli

1password: cli .installed-1password
.installed-1password:
	sudo rpm --import https://downloads.1password.com/linux/keys/1password.asc
	sudo sh -c 'echo -e "[1password]\nname=1Password Stable Channel\nbaseurl=https://downloads.1password.com/linux/rpm/stable/\$$basearch\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=\"https://downloads.1password.com/linux/keys/1password.asc\"" > /etc/yum.repos.d/1password.repo'
	sudo dnf install -y 1password 1password-cli
	touch .installed-1password

gui: 1password .installed-gui
.installed-gui:
	sudo dnf groupupdate -y core
	sudo dnf install -y \
		gnome-extensions-app gnome-shell-extension-appindicator gnome-tweaks mpv \
		gnome-shell-extension-dash-to-dock kitty intel-media-driver steam-devices \
		gnome-shell-extension-user-theme adw-gtk3-theme
	sudo dnf swap -y ffmpeg-free ffmpeg --allowerasing
	sudo dnf groupupdate -y multimedia --setopt="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin
	sudo dnf groupupdate -y sound-and-video
	cat dump.conf | dconf load /
	touch .installed-gui

docker: gui .installed-docker
.installed-docker:
	sudo dnf -y install dnf-plugins-core
	sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
	sudo dnf install -y \
		docker-ce docker-ce-cli containerd.io \
		docker-buildx-plugin docker-compose-plugin
	sudo systemctl enable --now docker
	sudo groupadd docker || true
	sudo usermod -aG docker $(USER) || true
	touch .installed-docker

flatpak: .installed-flatpak
.installed-flatpak:
	flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
	flatpak install -y flathub org.prismlauncher.PrismLauncher
	flatpak install -y flathub com.discordapp.Discord
	flatpak install -y flathub org.telegram.desktop
	flatpak install -y flathub com.obsproject.Studio
	flatpak install -y flathub dev.aunetx.deezer
	flatpak install -y flathub com.spotify.Client
	flatpak install -y flathub org.mozilla.Thunderbird
	flatpak install -y flathub com.valvesoftware.Steam
	touch .installed-flatpak
