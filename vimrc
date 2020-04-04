

" ===========================
" Content:
" 1. General
" 2. Plugins Settings
" 3. Plugins
" 4. Miscellaneous
" ===========================


""""""""""""""""""""""""""""""
" ==> General
""""""""""""""""""""""""""""""
" 1. Main
" 2. Mappings
" 3. Autocmds

" => Main
" Rename tabs to show tab# and # of viewports ---{{{
set tabpagemax=20
" The following is unnecessary because it is set in gruvbox
" hi TabLineSel term=bold cterm=bold ctermfg=16 ctermbg=229
" The second and third are the ones gives the black backgrouond for tab numbers
" TabWinNumSel is the selected tab's window number, i.e. the number after '.'
hi TabWinNumSel term=bold cterm=bold ctermfg=90 ctermbg=229
" TabNumSel is the selected tab's number, i.e. the number before '.'
hi TabNumSel term=bold cterm=bold ctermfg=16 ctermbg=229

" The following is unnecessary because it is set in gruvbox
" hi TabLine term=underline ctermfg=16 ctermbg=145
" The last two are for maintaining the black background
" when switched to other tabs
" TabWinNum is all the tab's window number, i.e. the numbers after '.'
hi TabWinNum term=bold cterm=bold ctermfg=90 ctermbg=145
" TabNum is all the tab's number, i.e. the numbers before '.'
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
            let s .= ' ' . file 
            let s .= (i == t ? '%m ' : ' ')
            let i = i + 1
        endwhile
        let s .= '%T%#TabLineFill#%='
        return s
    endfunction
    set stal=2
    set tabline=%!MyTabLine()
endif
"}}}
" Options settings ---{{{
set number
set relativenumber
set autoindent
set expandtab
set tabstop=4
set shiftwidth=4
set textwidth=78
set showcmd
" by default backspacing auto-indentation,
" line breaks or previous edits are not allowed.
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

syntax on
filetype plugin indent on
"}}}

" => Mappings
" General mappings ---{{{
" Don't use <esc> to go back to normal mode!
inoremap sd <esc>
vnoremap sd <esc>
nnoremap sd <esc>
" remapping <esc> only leads to problems
" for learning purpose
" inoremap <esc> <nop>
" vnoremap <esc> <nop>
" nnoremap <esc> <nop>

" set leader key to be the space bar
let mapleader = "\<Space>"
" maplocalleader is the same, except for the name,
" and is used for specific buffers
" let maplocalleader = "\\"
"}}}
" Normal mode mappings ---{{{
" for quick editing and sourcing of vimrc
nnoremap <Leader>ev :vs ~/.vim/vimrc<cr>
nnoremap <Leader>sv :source $MYVIMRC<cr>
nnoremap <Leader>sc :source %<cr>

" turn off highlighting when not searching
nnoremap <Leader><space> :noh<return><esc>

" navigate among windows in the same tab
" <C> is "Ctrl"
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" remapping 0 and $ with H and L
nnoremap H 0
nnoremap L $
nnoremap 0 H
nnoremap $ L
vnoremap H 0
vnoremap L $
vnoremap 0 H
vnoremap $ L

" highlight trailing whitespaces
" \zs: It matches anything, marks the start of the match
" \ze: It matches anything, marks the end of the match
" use <leader>ds to delete all trailing spaces
nnoremap <leader>es :execute "normal! mq/\\v\\S\\zs\\s+$\r`q"<cr>

" quick going through quickfix matches
nnoremap <leader>n :cnext<cr>
nnoremap <leader>p :cprevious<cr>

" go to the directory where the current file is in
" and prepare to open a file in the vertically split window.
nnoremap gb :vs %:h<cr>

" fun with vim regex: match an email address
" verymagic mode
nnoremap theEmail /\v([a-zA-Z0-9_\.\-])+\@([a-zA-Z0-9_\-])+(\.([a-zA-Z]){,5\}){,5\}<cr>
" magic mode
" nnoremap email /\([a-zA-Z0-9_\.\-]\)\+@\([a-zA-Z0-9_\-]\)\+\(\.\([a-zA-Z]\)\{,5}\)\{,5}<cr>

" change current split's width and height
" did not find a way to map using CTRL,
" (mapping punctuations seem unsupported)
" so have to press leader key arbitrary number of times...
" noremap <Leader>n <C-w><
" noremap <Leader>m <C-w>-
" noremap <Leader>, <C-w>+
" noremap <Leader>. <C-w>>
"}}}
" Visual mode mappings ---{{{
" for obtaining the selected texts
" and add chars to the front and back of it.
" obtain the selected text by using '\0'.
vnoremap s :/.*/
"}}}
" TODO: The operator-pending mappings for brackets should be
" re-written so that last visual selection is not changed and
" search highlight should not be turned on.
" Operator-pending mappings ---{{{
onoremap H 0
onoremap L $
" movement of change the content of the next/last parenthesis
" not recommended to use because new visual selection is invoked
" /r is an escape sequence meaning "carriage return",
" equivalent to pressing the return key
onoremap in( :<c-u>execute "normal! /(\rvi("<cr>
onoremap il( :<c-u>execute "normal! ?)\rvi("<cr>
onoremap in[ :<c-u>execute "normal! /[\rvi["<cr>
onoremap il[ :<c-u>execute "normal! ?]\rvi["<cr>
onoremap in{ :<c-u>execute "normal! /{\rvi{"<cr>
onoremap il{ :<c-u>execute "normal! ?}\rvi{"<cr>
onoremap in< :<c-u>execute "normal! /<\rvi<"<cr>
onoremap il< :<c-u>execute "normal! ?>\rvi<"<cr>
onoremap in" :<c-u>execute "normal! /\"\rlvi\""<cr>
onoremap il" :<c-u>execute "normal! ?\"\rhvi\""<cr>
onoremap in' :<c-u>execute "normal! /'\rlvi'"<cr>
onoremap il' :<c-u>execute "normal! ?'\rhvi'"<cr>

onoremap an( :<c-u>execute "normal! /(\rva("<cr>
onoremap al( :<c-u>execute "normal! ?)\rva("<cr>
onoremap an[ :<c-u>execute "normal! /[\rva["<cr>
onoremap al[ :<c-u>execute "normal! ?]\rva["<cr>
onoremap an{ :<c-u>execute "normal! /{\rva{"<cr>
onoremap al{ :<c-u>execute "normal! ?}\rva{"<cr>
onoremap an< :<c-u>execute "normal! /<\rva<"<cr>
onoremap al< :<c-u>execute "normal! ?>\rva<"<cr>
onoremap an" :<c-u>execute "normal! /\"\rlva\""<cr>
onoremap al" :<c-u>execute "normal! ?\"\rhva\""<cr>
onoremap an' :<c-u>execute "normal! /'\rlva'"<cr>
onoremap al' :<c-u>execute "normal! ?'\rhva'"<cr>
" Question: how to have the string of command containing regex?
" it seems like the search pattern does not work
" when \r and other chars append at the back of the search string.
"}}}

" => Autocmds
" augroup discussions ---{{{
" benefit of augroup
" 1. group autocmds together
" 2. avoid duplication of those commands
"    after sourcing the file by using autocmd!
"    to clear the autocmds.
" 3. if there are some groups with the same name
"    only the first one will be called and executed.
augroup forLols
    autocmd!
    autocmd VimEnter * echo 'Welcome To Vim >^.^<'
augroup END

" e.g. the following will not be called
" augroup forLols
"   autocmd VimEnter * echo 'I don't want to say anything!'
" augroup END
"}}}
" Vimscript file settings ---{{{
augroup vimFiles
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
    autocmd FileType help wincmd L | vertical resize 78
    autocmd FileType vim nnoremap <buffer> <localleader>c I"<space><esc>
augroup END
"}}}
" Python file settings ---{{{
augroup pythonFiles
    au!
    au BufNewFile,BufRead *.py
                \ setlocal tabstop=4        |
                \ setlocal softtabstop=4    |
                \ setlocal shiftwidth=4     |
                \ setlocal textwidth=80     |
                \ setlocal expandtab        |
                \ setlocal autoindent       |
                \ setlocal fileformat=unix  |
                \ setlocal conceallevel=1
    au FileType python nnoremap <buffer> <F9> :w <bar> :exec '!python' shellescape(@%, 1)<cr>
    " example of writing a snippet using vimscript
    au FileType python :iabbrev <buffer> iff if:<left>
    " commenting snippet for python
    au FileType python nnoremap <buffer> <localleader>c I#<space><esc>
augroup END
"}}}
" Latex file settings ---{{{
augroup latexFiles
    au!
    au BufNewFile,BufRead *.tex
                \ setlocal tabstop=4        |
                \ setlocal shiftwidth=4     |
                \ setlocal textwidth=80     |
                \ setlocal expandtab        |
                \ setlocal autoindent       |
                \ setlocal conceallevel=2
    autocmd FileType tex nnoremap <buffer> <localleader>c I%<space><esc>
augroup END
"}}}
" HTML file settings ---{{{
augroup htmlFiles
    au!
    au BufWritePre,BufRead *.html :normal! gg=G
augroup END
"}}}
" JavaScript file settings ---{{{
augroup javascriptFile
    au!
    au FileType javascript  nnoremap <buffer> <localleader>c    I//<space><esc>
augroup END
"}}}

""""""""""""""""""""""""""""""
" ==> End General
""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""
" ==> Plugins and settings
""""""""""""""""""""""""""""""
" vundle ---{{{
" :PluginInstall for installation
" :PluginClean to remove undeclared plugins
" :PluginUpdate to update the plugins
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" install Vundle(Vim Bundle)
Plugin 'gmarik/Vundle.vim'
" vim theme
Plugin 'morhetz/gruvbox'
" status/tabline for vim at the bottom of each window
Plugin 'vim-airline/vim-airline'
" themes for vim-airline
Plugin 'vim-airline/vim-airline-themes'
" Asynchronous Lint Engine for syntax checking nad semnantic errors
Plugin 'dense-analysis/ale'
" 'vim' finder
Plugin 'scrooloose/nerdtree'
" snippets for different languages/filetype
Plugin 'sirver/ultisnips'
" Snippets are separated from the engine. Add this if you want them:
Plugin 'honza/vim-snippets'

call vundle#end()
"}}}
" vim-plug ---{{{
" :PlugInstall for installation
" :PlugClean to remove undeclared plugins
" :PlugUpdate to update all plugins
call plug#begin('~/.vim/plugged')

" Conquer of Completion
Plug 'neoclide/coc.nvim', {'branch' : 'release'}
" latex for vim
Plug 'lervag/vimtex'
" further latex conceal level support
Plug 'KeitaNakamura/tex-conceal.vim', {'for': 'tex'}

call plug#end()
"}}}
" ale settings ---{{{
" to jump between errors and warnings
" must be nmap instead of nnoremap because the command involves in recursion
nmap <silent> <C-m> <Plug>(ale_previous_wrap)
nmap <silent> <C-n> <Plug>(ale_next_wrap)
" toggle ale on and off
nnoremap <Leader>ta :ALEToggle<CR>
let g:ale_sign_error = '❌'
let g:ale_sign_warning = '⚠️'
let g:ale_open_list = 1
" control the time for ale to do linting
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
" show errors and warnings in the status line
let g:airline#extension#ale#enabled = 1
" error window closes together when the main window closes
autocmd QuitPre * if empty(&bt) | lclose | endif
" airline theme
let g:airline_theme = 'base16_gruvbox_dark_hard'
"}}}
" NERDTree settings ---{{{
nnoremap <Leader>tt :NERDTreeToggle<CR>
" NERDTree window closes together with the main window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" move nerdtree to the right
let g:NERDTreeWinPos = "right"
"}}}
" COC settings ---{{{
" Use <C-j> and <C-k> to navigate the completion list
" inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
" inoremap <expr> <C-k> pumvisible() ? "\<C-P>" : "\<C-k>"
"}}}
" ultisnips settings ---{{{
" the following four settings are just not working...
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsListSnippets = "<c-tab>"
let g:UltiSnipsJumpForwardTrigger = "<c-j>"
let g:UltiSnipsJumpBackwardTrigger = "<c-k>"
" :UltiSnipsEdit split window mode - new tab
let g:UltiSnipsEditSplit = "tabdo"
"}}}
" vimtex settings ---{{{
let g:tex_flavor='latex'
" let g:vimtex_view_method='mupdf'
let g:vimtex_quickfix_mode=0
let g:tex_conceal='abdgm'
"}}}
" Fugitive settings ---{{{
augroup FugitiveSettings
    au!
    " autocmd BufReadPost fugitive://* set bufhidden=delete
augroup END

colorscheme gruvbox
""""""""""""""""""""""""""""""
" ==> End Plugins and settings
""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""
" ==> Miscellaneous
""""""""""""""""""""""""""""""

" typing the second word will change to the remaining text automatically
" common typo
iabbrev waht what
" Personal info
iabbrev @@ ariszyq123@gmail.com
iabbrev ccopy Copyright 2020 Aris Zhu Yi Qing, all rights reserved.

""""""""""""""""""""""""""""""
" ==> End Miscellaneous
""""""""""""""""""""""""""""""
