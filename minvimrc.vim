" After setting up this minimum vimrc file,
" start vim with command "vim -u minvimrc.vim",
" and then operate with vim with this vimrc config.
set nocp

call plug#begin('~/.vim/plugged')
" Use release branch (Recommend)
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end() 
