# My *nvim* Config 

This is my personal neovim config build over time from several sources.


## Install

Get nvim for Linux or Windows:

- Linux: Install from source, go to github
- Windows: Install binary, also github

### Config Repository

Clone the repository into your config folder.
When starting nvim, it should auto install all the packages.

### LSP Servers

Mason installs the LSP servers but it needs some tools to do that:

- `npm` (Common on linux systems, not so common on Windows systems)
- `gcc` and `g++` (native on linux, Windows needs installation)

- `pip3` (sometimes servers can be manually installed by pip3)


To use the LSP servers you need to specify the servers in `lua/plugins/lsp/lspconfig.lua`


`
-- configure python server
lspconfig["pyright"].setup({
    capabilities = capabilities,
    -- on_attach = on_attach, -- the keymaps are attached to that
})
`



### Ripgrep

Ripgrep is needed for Telescope

Linux:
`
sudo apt install ripgrep
`

Windows:
`
choco install ripgrep
`


## Dependencies

The nvim config needs some dependencies to work properly.

- ~~`npm` to install `pyright` as lsp server for python~~
- pyright can also be installed via pip
- `ripgrep` for telescope live_grep (windows choco)
- `gcc` and `g++` are nice to have


## Install Guide

Some installation guide how I installed neovim on my systems.

### Linux

- **Build Neovim from source**, to get the latest version of neovim on linux 
systems, better build from source. The installation is pretty easy and well 
explained on the github page. 

[Github Build from source](https://github.com/neovim/neovim/wiki/Installing-Neovim#install-from-source), [Github Quick Start](https://github.com/neovim/neovim/wiki/Building-Neovim)

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



## Personal Thoughts

I used vim before and started to move my config to nvim since it offers a lot 
more plugins and possibilities. But it is a pain in the ass to configure...
The integration of lua really upgrades vim but at the same time it is the worst
in terms of configuration. Everyone handles things differently and thats why 
it is out of control to easy configure your text editor. Every package is
not maintained after a year, the plug in managers changes regularly, configs 
sometimes do not work anymore. When installing a package, it will not work for 
the first time. Error warnings at startup and nothing works. I hate it. 
It is like writing your own text editor with the same editor. 
