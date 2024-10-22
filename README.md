# My nvim Config 

This is my personal neovim config build over time from several sources. I tried 
to stick with the default key settings as much as possible and I like it 
minimalistic so it works on every machine. 



## Software dependencies

- `ripgrep` (Windows: choco), for fuzzy finding in Telescope
- `gcc` and `g++`, for Mason, Treesitter, and other plugins I guess
- `npm`, handy for LSP servers
- `pip3` (manual installation for pyright)




## Personal Thoughts

I used vim before and started to move my config to nvim since it offers a lot 
more plugins and possibilities. But it is a pain in the ass to configure...
The integration of lua really upgrades vim but at the same time it is the worst
in terms of configuration. Everyone handles things differently and that's why 
it is out of control to easy configure your text editor. Every package is
not maintained after a year, the plugin managers changes regularly, configs 
sometimes do not work anymore. When installing a package, it will not work for 
the first time. Error warnings at startup and nothing works. I hate it. 
It is like writing your own text editor with the same editor. 

_Update 2024-08-17_
Maybe it is better now since neovim is getting more stable and used by more and 
more people. Still most of the things above are true.

_Update 2024-10-22_
As I more and more sharpen my config for neovim I think I get the syntax and
structure why it is built up but it is still a mess with all the lua functions
and personal and super personal config stuff. I plan to update my config once
every year in October/November and leave it then. I am still working with
packer as my plugin manager and I have nightmares thinking about switching to
lazy. But I think there will be no way out...


