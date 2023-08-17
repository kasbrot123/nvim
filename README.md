# My .nvim Config 

This is my neovim config. 

I used vim before and started to move my config to nvim since it offers a lot 
more plugins and possibilities. But it is a pain in the ass to configure...

## Dependencies

The nvim config needs some dependencies to work properly.

~~- `npm` to install `pyright` as lsp server for python~~
- pyright can also be installed via pip
- `ripgrep` for telescope live_grep (windows choco)
- `gcc` and `g++` are nice to have


## Install Guide

Some installation guide how I installed neovim on my systems.

### Linux

- **Build Neovim from source**, to get the latest version of neovim on linux 
systems, better build from source. The installation is pretty easy and well 
explained on the github page. 

[Github Build from source](https://github.com/neovim/neovim/wiki/Installing-Neovim#install-from-source)

[Github Quick Start](https://github.com/neovim/neovim/wiki/Building-Neovim)

```
sudo apt-get install ninja-build gettext cmake unzip curl
git clone https://github.com/neovim/neovim
cd neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install
```

- **Package manager**, most package managers can install neovim but since neovim 
is constantly under development, they do not support the latest releases. 

### Windows

- **Installation via binary**, there is a release page on github (neovim) where
binaries for windows with the latest versions are released. 




