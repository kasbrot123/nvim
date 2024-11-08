# My nvim Config 

This is my personal neovim config build over time from several sources. I tried 
to stick with the default key settings as much as possible and I like it 
minimalistic so it works on every machine. 



## Software dependencies

- `python` and `pip3`
- `npm` (for LSP servers and stuff)
- `gcc` and `g++` (for Mason, Treesitter, and other plugins I guess)
- `ripgrep` (for fuzzy finding in Telescope)


### Python and nodejs

On Windows use the installers. It is straight forward for both.


### `gcc` and `g++` (for Windows)

1. Search for MinGW-w64 and go to their homepage.
2. Go to downloads (https://www.mingw-w64.org/downloads/)
3. Search for mingw-w64 and go to their github page. 
4. Select something like this `**x86_64-13.2.0-release-win32-seh-msvcrt-rt_v11-rev1.7z**`
5. Paste it into C:\ and set the global path variable.


*Note: I experienced errors when using the MinGW 32-bit version (or the
compiler). It did not work with neovim treesitter*


### `ripgrep`

- On Linux you can use your package manager.
- On Windows the easiest way is via powershell:

```powershell
winget install BurntSushi.ripgrep.MSVC
```


## Treeshitter problems

Treesitter does not work by default with my config, this is so anoying. You
cannot read the help, after every key press you get an error. Something like
this:

```
Error in decoration provider treesitter/highlighter.win
```

A fix might be:

```
:TSInstall vim vimdoc
````

And maybe you also need:

```
npm -g install tree-sitter-cli
:TSInstall latex
```

## ConstrainedLanguage Mode

On some Windows machines Mason cannot installe language servers when the
ConstrainedLanguage mode is on. You can check the mode via the powershell:

```
$ExecutionContext.SessionState.LanguageMode
```

Example:

```
PS C:\Users\kasbrot123> $ExecutionContext.SessionState.LanguageMode
ConstrainedLanguage
```

To set the Language Mode of the machine to `FullLanguage` you can change the
registry key from `4` to `8`.

```
Computer\HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment
```

- `4`: `ConstrainedLanguage`
- `8`: `FullLanguage`

https://stackoverflow.com/questions/57032747/how-to-change-powershell-mode-to-fulllanguage-mode-from-constrained-mode



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


