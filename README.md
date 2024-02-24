```
      d8b                    ,d8888b d8,  d8b
      88P            d8P     88P'   '8P   88P
     d88          d888888Pd888888P       d88
 d888888   d8888b   ?88'    ?88'     88b 888   d8888b .d888b,
d8P' ?88  d8P' ?88  88P     88P      88P ?88  d8b_,dP ?8b,
88b  ,88b 88b  d88  88b    d88      d88   88b 88b       '?8b
'?88P''88b'?8888P'  '?8b  d88'     d88'    88b'?888P''?888P'
```

My dotfiles to bootstrap a fresh Fedora installation.
Should work on other distros with minimal edits in the Makefile.

### How to use:

```sh
git clone https://git.sr.ht/~ansipunk/dotfiles
cd dotfiles
make
```

It is advised to restart your machine after installing some of GUI and Docker packages.

### What's included:

- Configs for various CLI tools including tmux and Neovim;
- Removing some GNOME clutter;
- Installing a bunch of packages including build stuff, OBS Studio, Spotify,
  1Password, Telegram Desktop, some other GUI apps, Flatpak, RPMFusion,
  Deezer and a few of essential GNOME shell extensions;
- Language servers for some of the languages;
- Docker;
- Nice fonts.

### What's not included:

- GNOME configs: dconf is shit and GNOME is rarely backwards compatible;
- Wallpapers: do you even see your wallpaper except when you are making a screenshot?
