# Info
This vimrc is geared towards python programming and latex editing on Mac. 
Main plugins used:
1. colorscheme: gruvbox
2. linting: ale
3. code completion: coc
4. snippets: ultisnips
5. latex: vimtex
6. file search: fzf
7. file explorer: Vifm + Defx
8. LSP symbols/tags viewer/finder: Vista
9. vim start screen: Startify
10. git integration: fugitive
11. quick navigation: Easymotion
12. indication of changes managed by VCS: Signify

# Installation

1. Go to Home directory and clone the repo, then change the name
```
cd
git clone https://github.com/qsmy41/vimConfig
mv vimConfig/ .vim/
```
2. Clone Vundle repo for plugins
```
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```
3. open .vimrc
```
vim .vimrc
```
4. change its content to one-line `runtime vimrc`.
5. Source vimrc and install the plugins
```
:source ~/.vimrc
:PluginInstall
:PlugInstall
```


