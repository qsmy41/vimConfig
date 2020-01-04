""""""""""""""""""""""""""""""
" => General
""""""""""""""""""""""""""""""
set number
set relativenumber
set autoindent
set expandtab
set tabstop=2
set shiftwidth=4
set showcmd
" by default backspacing auto-indentation, line breaks or previous edits are not allowed.
set backspace=indent,eol,start 
" Enable highlightiing matching search patterns and incremental search
set incsearch
set hlsearch
set ignorecase

" FINDING FILES
" search down into subfolders
" provide tab-completion for all file-related tasks
set path+=**
" display all matching files while tab completion
set wildmenu

" turn off highlighting when not searching
" <Leader> is '\'
nnoremap <Leader><space> :noh<return><esc>
" jump to the previous cursor position
nnoremap <C-p> <C-o>

" navigate among windows in the same tab
" <C> is "Ctrl"
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

"Rename tabs to show tab# and # of viewports
set tabpagemax=15
hi TabLineSel term=bold cterm=bold ctermfg=16 ctermbg=229
hi TabWinNumSel term=bold cterm=bold ctermfg=90 ctermbg=229
hi TabNumSel term=bold cterm=bold ctermfg=16 ctermbg=229
hi TabLine term=underline ctermfg=16 ctermbg=145
hi TabWinNum term=bold cterm=bold ctermfg=90 ctermbg=145
hi TabNum term=bold cterm=bold ctermfg=16 ctermbg=145
if exists("+showtabline")
    function! MyTabLine()
        let s = ''
        let wn = ''
        let t = tabpagenr()
        let i = 1
        while i <= tabpagenr('$')
            let buflist = tabpagebuflist(i)
            let winnr = tabpagewinnr(i)
            let s .= '%' . i . 'T'
            let s .= (i == t ? '%1*' : '%2*')
            let s .= ' '
            let wn = tabpagewinnr(i,'$')

            let s .= (i== t ? '%#TabNumSel#' : '%#TabNum#')
            let s .= i
            if tabpagewinnr(i,'$') > 1
                let s .= '.'
                let s .= (i== t ? '%#TabWinNumSel#' : '%#TabWinNum#')
                let s .= (tabpagewinnr(i,'$') > 1 ? wn : '')
            end

            let s .= ' %*'
            let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')
            let bufnr = buflist[winnr - 1]
            let file = bufname(bufnr)
            let buftype = getbufvar(bufnr, 'buftype')
            if buftype == 'nofile'
                if file =~ '\/.'
                    let file = substitute(file, '.*\/\ze.', '', '')
                endif
            else
                let file = fnamemodify(file, ':p:t')
            endif
            if file == ''
                let file = '[No Name]'
            endif
            let s .= file
            let s .= (i == t ? '%m' : '')
            let i = i + 1
        endwhile
        let s .= '%T%#TabLineFill#%='
        return s
    endfunction
    set stal=2
    set tabline=%!MyTabLine()
endif

""""""""""""""""""""""""""""""
" => Plugins Settings
""""""""""""""""""""""""""""""

" ale settings
" to jump between errors and warnings
nnoremap <silent> <C-m> <Plug>(ale_previous_wrap)
nnoremap <silent> <C-n> <Plug>(ale_next_wrap)
let g:ale_sign_error = '❌'
let g:ale_sign_warning = '⚠️'
let g:ale_open_list = 1
" control the time for ale to do linting
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
" error window closes together when the main window closes
autocmd QuitPre * if empty(&bt) | lclose | endif

" load up the nerd tree
autocmd vimenter * NERDTree
map <Leader>t <plug>NERDTreeTabsToggle<CR>
" NERDTree window closes together with the main window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" move nerdtree to the right
let g:NERDTreeWinPos = "right"
" move to the first buffer
autocmd VimEnter * wincmd p
autocmd BufWinEnter * NERDTreeMirror

" Use <S-j> and <S-k> to navigate the completion list
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-P>" : "\<C-k>"

" ultisnips settings
" the following four settings are just not working...
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsListSnippets = "<c-tab>"
let g:UltiSnipsJumpForwardTrigger = "<c-l>"
let g:UltiSnipsJumpBackwardTrigger = "<c-h>"
" :UltiSnipsEdit split window mode - new tab
let g:UltiSnipsEditSplit = "tabdo"

"""""""""""""""""""""""""""""
" Plug-ins
"""""""""""""""""""""""""""""

" vundle
" call :PluginInstall for installation
" call :PluginClean to remove undeclared plugins
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" install Vundle(Vim Bundle)
Plugin 'gmarik/Vundle.vim'
" vim theme
Plugin 'morhetz/gruvbox'
" status/tabline for vim at the bottom of each window
Plugin 'vim-airline/vim-airline'
" Asynchronous Lint Engine for syntax checking nad semnantic errors
Plugin 'dense-analysis/ale'
" 'vim' finder
Plugin 'scrooloose/nerdtree'
" snippets for different languages/filetype
Plugin 'sirver/ultisnips'
" Snippets are separated from the engine. Add this if you want them:
Plugin 'honza/vim-snippets'

call vundle#end()

" vim-plug
" call :PlugInstall for installation
" call :PlugClean to remove undeclared plugins
call plug#begin('~/.vim/plugged')

" Conquer of Completion
Plug 'neoclide/coc.nvim', {'branch' : 'release'}
" latex for vim
Plug 'lervag/vimtex'

call plug#end()

syntax on
filetype plugin indent on
colorscheme gruvbox

""""""""""""""""""""""""""""""
" => Latex section
""""""""""""""""""""""""""""""

au BufNewFile, BufRead *.tex
  let g:tex_flavor='latex'
  let g:vimtex_view_method='mupdf'
  let g:vimtex_quickfix_mode=0
  set conceallevel=1
  let g:tex_conceal='abdmg'

""""""""""""""""""""""""""""""
" => Python section
""""""""""""""""""""""""""""""

au BufNewFile, BufRead *.py
  \ set tabstop=4
  \ set softtabstop=4
  \ set shiftwidth=4
  \ set textwidth=79
  \ set expandtab
  \ set autoindent
  \ set fileformat=unix
  nnoremap <buffer> <F9> :w <bar> :exec '!python' shellescape(@%, 1)<cr>

