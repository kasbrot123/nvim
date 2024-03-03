# My *nvim* Config 

This is my personal neovim config build over time from several sources.


## Install

### Installation of Nvim

For Linux and Windows: go to github and see for documentation.

### 1. Clone Repo

Clone the repository into your config folder, start nvim.

### 2. Software dependencies

- `ripgrep` (Windows: choco)
- `gcc` and `g++`
- `npm`
- `pip3` (manual installation for pyright)


### 3. Configure LSP Servers

To use the LSP servers you need to specify the servers in `lua/plugins/lsp/lspconfig.lua`

```lua
-- configure python server
lspconfig["pyright"].setup({
    capabilities = capabilities,
    -- on_attach = on_attach, -- the keymaps are attached to that
})

```

### 4. Treesitter (`:TSUpdate`, `:TSInstall <language>`)

Install treesitter syntax highlighting in the command line, it is easier and not
so anoying when some dependencies are not installed. 


```
:TSInstall vim markdown python ...

```




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
