
" 1. coc cannot retrieve vim symbols,
" therefore vista.vim does not work.
" 2. debugging tools?
" checkout vimspector and possibly others next time.


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
set background=dark
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

" set MacVim's font
set guifont=Hack\ Nerd\ Font:h18

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

" quick editing ultisnips
nnoremap <Leader>es :UltiSnipsEdit<cr>

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

" yank to the system clipboard
nnoremap <leader>y "+y

" substitute the word under the cursor and repeatable substitutes
nnoremap s* :let @/='\<' . expand('<cword>') . '\>'<cr>cgn

" highlight trailing whitespaces
" \zs: It matches anything, marks the start of the match
" \ze: It matches anything, marks the end of the match
" use <leader>ds to delete all trailing spaces
nnoremap <leader>ss :execute "normal! mq/\\v\\S\\zs\\s+$\r`q"<cr>

" quick going through quickfix matches and toggle them
nnoremap ]q :cnext<cr>
nnoremap [q :cprev<cr>
nnoremap ]Q :clast<cr>
nnoremap [Q :cfirst<cr>
nnoremap [o :copen<cr>
nnoremap ]o :cclose<cr>

" go to the directory where the current file is in
" and prepare to open a file in the vertically split window.
nnoremap gb :vs %:h<cr>

" fun with vim regex: match an email address
" verymagic mode
nnoremap theEmail /\v([a-zA-Z0-9_\.\-])+\@([a-zA-Z0-9_\-])+(\.([a-zA-Z]){,5\}){,5\}<cr>
" magic mode
" nnoremap email /\([a-zA-Z0-9_\.\-]\)\+@\([a-zA-Z0-9_\-]\)\+\(\.\([a-zA-Z]\)\{,5}\)\{,5}<cr>
"}}}
" Visual mode mappings ---{{{
" consider dropping this because it is a bit useless.
" for obtaining the selected texts
" and add chars to the front and back of it.
" obtain the selected text by using '\0'.
vnoremap ss :s/.*/\0<left><left>

" substitute the visually selected words
vnoremap s* "qy:let @/=@q<cr>cgn

" go to start and end of line in visual mode
vnoremap H 0
vnoremap L $
vnoremap 0 H
vnoremap $ L

" yank to system clipboard
vnoremap <leader>y "+y
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
    autocmd BufEnter * silent! lcd %:p:h
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
" Asynchronous Linting Engine for syntax checking nad semnantic errors
Plugin 'dense-analysis/ale'
" snippets for different languages/filetype
Plugin 'sirver/ultisnips'
" vim file explorer
Plugin 'vifm/vifm.vim'

call vundle#end()
"}}}
" vim-plug ---{{{
" :PlugInstall for installation
" :PlugClean to remove undeclared plugins
" :PlugUpdate to update all plugins
call plug#begin('~/.vim/plugged')

" Conquer of Completion: Intellisense engine
Plug 'neoclide/coc.nvim', {'branch' : 'release'}
" latex for vim
Plug 'lervag/vimtex'
" further latex conceal level support
Plug 'KeitaNakamura/tex-conceal.vim', {'for': 'tex'}
" C language plugin
" Plug 'vim-scripts/c.vim'
" Git integration with vim
Plug 'tpope/vim-fugitive'
" File search in vim and path to the main fzf
Plug 'junegunn/fzf.vim'
Plug '/usr/local/opt/fzf'
" start screen plugin
Plug 'mhinz/vim-startify'
" viewing and searching LSP symbols, tags
Plug 'liuchengxu/vista.vim'
" file explorer
Plug 'Shougo/defx.nvim'
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'
" change 'surroundings'
Plug 'tpope/vim-surround'
" quick navigation
Plug 'easymotion/vim-easymotion'
" use sign column to show change to a file managed by VCS
Plug 'mhinz/vim-signify', { 'branch': 'legacy' }

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
" COC settings ---{{{
" Use <C-j> and <C-k> to navigate the completion list
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-P>" : "\<C-k>"

" ":CocList extensions" to look up installed coc extensions
" ":CocInstall xxx" to install desired extensions/LSPs
"}}}
" ultisnips settings ---{{{
" the following four settings are just not working...
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsListSnippets = "<c-tab>"
let g:UltiSnipsJumpForwardTrigger = "<c-l>"
let g:UltiSnipsJumpBackwardTrigger = "<c-h>"
" :UltiSnipsEdit split window mode - new tab
let g:UltiSnipsEditSplit = "tabdo"
nnoremap <leader>es :UltiSnipsEdit<cr>
"}}}
" vimtex settings ---{{{
let g:tex_flavor='latex'
let g:vimtex_quickfix_mode=0
let g:tex_conceal='abdgm'

" it should be vimtex_view_method, but that doesn't work
let g:vimtex_view_general_viewer='zathura'

" the following only works when vimtex_view_method is set to zathura
" instead of the current vimtex_view_general_viewer.
" let g:vimtex_view_zathura_hook_view='ViewerPosition'
" function! ViewerPosition() abort dict
"       echom 'See what I am:' string(self)
"   " call self.move('0 0')
"   " call self.resize('1600 876')
" endfunction

" For synctex forward
" au FileType tex nmap <Leader>f :call SyncTexForward()<CR>
" function! SyncTexForward()
"     let execstr = "silent !zathura --synctex-forward ".line(".").":".col(".").":%:p %:p:r.pdf &"
"     exec execstr
" endfunction
"}}}
" C-vim settings ---{{{
let g:C_UseTool_cmake   = 'yes'
let g:C_UseTool_doxygen = 'yes'
"}}}
" Vifm settings ---{{{
" Color scheme setting:
" follow the instructions on: https://wiki.vifm.info/index.php/Color_schemes
" to set up ~/.vifm accordingly
" search for the desired color scheme, like gruvbox, and then copy it.

" fw: File Window
" nnoremap <leader>fw :Vifm ~/ %:h<cr>
"}}}
" fugitive settings ---{{{
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>gd :Gvdiffsplit<cr>
nnoremap <leader>gw :Gwrite<cr>
nnoremap <leader>gr :Gread<cr>
nnoremap <leader>gc :Gcommit<cr>
nnoremap <leader>gv :Gremove<cr>
nnoremap <leader>gm :Gmove
nnoremap <leader>gh :Gblame<cr>
nnoremap <leader>gl :Glog<cr>
nnoremap <leader>gp :Gpush<cr>
nnoremap <leader>gb :Gbranch<cr>
"}}}
" fzf settings ---{{{
" in command line "brew install the_silver_searcher"
" so that :FzfAg can be used
nnoremap <leader>ff :Files %:h
nnoremap <leader>fa :Ag<cr>
nnoremap <leader>fg :GFiles<cr>
nnoremap <leader>fb :Buffers<cr>
nnoremap <leader>fl :Lines<cr>
nnoremap <leader>fw :Windows<cr>
nnoremap <leader>fs :Snippets<cr>
nnoremap <leader>fc :Commits<cr>
nnoremap <leader>ft :Tags<cr>
nnoremap <leader>fm :Marks<cr>
" non-conventional mappings
nnoremap <leader>f, :Maps<cr>
nnoremap <leader>fd :Helptags<cr>
nnoremap <leader>fz :Commands<cr>
" search for opened files
nnoremap <leader>fh :History<cr>
" search for commands
nnoremap <leader>f: :History:<cr>
" search for search histories
nnoremap <leader>f/ :History/<cr>
" for searching system files
nnoremap <leader>fn :Locate 

" Change branches with Gbranch, the custom fuzzy function
fun! s:change_branch(e)
    let res = system("git checkout ", a:e)
    " reload the current file
    :e!
    :AirlineRefresh
    echom "Change branch to" . a:e
endfun
command! Gbranch call fzf#run({
            \ 'source': 'git branch',
            \ 'sink': function('<SID>change_branch'),
            \ 'option': '-m',
            \ 'down': '20%'
            \ })

" For syntax highlighting of the preview window, "brew install bat"
" Then install gruvbox theme following the instructions on:
" https://github.com/sharkdp/bat#adding-new-themes
" with git clone https://github.com/ethe/gruvbox-sublime

" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

" An action can be a reference to a function that processes selected lines
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Default fzf layout
" - down / up / left / right
let g:fzf_layout = { 'down': '~40%' }

" Always enable preview window on the right with 60% width
let g:fzf_preview_window = 'right:60%'
" Customize fzf colors to match your color scheme
" - fzf#wrap translates this to a set of `--color` options
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }
"}}}
" Startify settings ---{{{
let g:startify_files_number = 8
let g:startify_bookmarks = [
            \ {'z': '~/.zshrc'},
            \ {'x': '~/.tmux.conf'},
            \ {'c': '~/.vim/vimrc'}]
let g:ascii = [
            \ '     O            /                       \                                   ',
            \ '                /X/                       \X\                                 ',
            \ '       O       |XX\         _____         /XX|                                ',
            \ '            o  |XXX\     _/       \_     /XXX|___________                     ',
            \ '                \XXXXXXX             XXXXXXX/            \\\                  ',
            \ '                  \XXXX    /     \    XXXXX/                \\\               ',
            \ '                       |   0     0   |                         \              ',
            \ '                        |           |                           \         //  ',
            \ '                         \         /                            |________//   ',
            \ '                          \       /                             |             ',
            \ '                           | O_O | \                            |             ',
            \ '                            \ _ /   \________________           |             ',
            \ '                                       | |  | |      \         /              ',
            \ '                                       / |  / |       \______/                ',
            \ '                                       \ |  \ |        \ |  \ |               ',
            \ '                                     __| |__| |      __| |__| |               ',
            \ '                                     |___||___|      |___||___|               ',
            \ ]
let g:startify_custom_header = startify#fortune#boxed() + g:ascii
"}}}
" Vista settings ---{{{
" currently coc-vimlsp does not support symbol extraction
" so vimscipts cannot use visa

nnoremap <leader>vs :Vista!!<cr>
nnoremap <leader>vf :Vista finder<cr>

function! NearestMethodOrFunction() abort
return get(b:, 'vista_nearest_method_or_function', '')
endfunction

set statusline+=%{NearestMethodOrFunction()}

" By default vista.vim never run if you don't call it explicitly.
"
" If you want to show the nearest function in your statusline automatically,
" you can add the following line to your vimrc
autocmd VimEnter * call vista#RunForNearestMethodOrFunction()

" How each level is indented and what to prepend.
" This could make the display more compact or more spacious.
" e.g., more compact: ["▸ ", ""]
" Note: this option only works the LSP executives, doesn't work for `:Vista ctags`.
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]

" Executive used when opening vista sidebar without specifying it.
" See all the avaliable executives via `:echo g:vista#executives`.
let g:vista_default_executive = 'coc'

" let g:vista_finder_alternative_executives = ['coc']

" Set the executive for some filetypes explicitly. Use the explicit executive
" instead of the default one for these filetypes when using `:Vista` without
" specifying the executive.
" let g:vista_executive_for = {
" \ 'cpp': 'coc',
" \ 'php': 'vim_lsp',
" \ 'vim': 'coc',
" \ }

" Declare the command including the executable and options used to generate ctags output
" for some certain filetypes.The file path will be appened to your custom command.
" For example:
let g:vista_ctags_cmd = {
  \ 'haskell': 'hasktags -x -o - -c',
  \ }

" To enable fzf's preview window set g:vista_fzf_preview.
" The elements of g:vista_fzf_preview will be passed as arguments to fzf#vim#with_preview()
" For example:
let g:vista_fzf_preview = ['right:50%']

" Ensure you have installed some decent font to show these pretty symbols, then you can enable icon for the kind.
let g:vista#renderer#enable_icon = 1

" The default icons can't be suitable for all the filetypes, you can extend it as you wish.
let g:vista#renderer#icons = {
\   "function": "\uf794",
\   "variable": "\uf71b",
\  }
"}}}
" Defx settings ---{{{

nnoremap <leader>fe :Defx -split=vertical -winwidth=30 -direction=topleft<cr>
" update Defx as files are updated
autocmd BufWritePost * call defx#redraw()

autocmd FileType defx call s:defx_my_settings()
function! s:defx_my_settings() abort
  " Define mappings
  nnoremap <silent><buffer><expr> <CR>  defx#do_action('open')
  nnoremap <silent><buffer><expr> c     defx#do_action('copy')
  nnoremap <silent><buffer><expr> m     defx#do_action('move')
  nnoremap <silent><buffer><expr> p     defx#do_action('paste')
  nnoremap <silent><buffer><expr> l     defx#do_action('open')
  nnoremap <silent><buffer><expr> E     defx#do_action('open', 'vsplit')
  nnoremap <silent><buffer><expr> P     defx#do_action('open', 'pedit')
  nnoremap <silent><buffer><expr> o     defx#do_action('open_or_close_tree')
  nnoremap <silent><buffer><expr> K     defx#do_action('new_directory')
  nnoremap <silent><buffer><expr> N     defx#do_action('new_file')
  nnoremap <silent><buffer><expr> M     defx#do_action('new_multiple_files')
  nnoremap <silent><buffer><expr> S     defx#do_action('toggle_sort', 'time')
  nnoremap <silent><buffer><expr> d     defx#do_action('remove')
  nnoremap <silent><buffer><expr> r     defx#do_action('rename')
  nnoremap <silent><buffer><expr> !     defx#do_action('execute_command')
  nnoremap <silent><buffer><expr> x     defx#do_action('execute_system')
  nnoremap <silent><buffer><expr> yy    defx#do_action('yank_path')
  nnoremap <silent><buffer><expr> .     defx#do_action('toggle_ignored_files')
  nnoremap <silent><buffer><expr> ;     defx#do_action('repeat')
  nnoremap <silent><buffer><expr> h     defx#do_action('cd', ['..'])
  nnoremap <silent><buffer><expr> ~     defx#do_action('cd')
  nnoremap <silent><buffer><expr> q     defx#do_action('quit')
  nnoremap <silent><buffer><expr> *     defx#do_action('toggle_select_all')
  nnoremap <silent><buffer><expr> j     line('.') == line('$') ? 'gg' : 'j'
  nnoremap <silent><buffer><expr> k     line('.') == 1 ? 'G' : 'k'
  nnoremap <silent><buffer><expr> <C-r> defx#do_action('redraw')
  nnoremap <silent><buffer><expr> <C-g> defx#do_action('print')
  nnoremap <silent><buffer><expr> cd    defx#do_action('change_vim_cwd')
  nnoremap <silent><buffer><expr> <C-h> '<C-w>h'
  nnoremap <silent><buffer><expr> <C-l> '<C-w>l'
  nnoremap <silent><buffer><expr> <Space> defx#do_action('toggle_select') . 'j'
  nnoremap <silent><buffer><expr> C
  \ defx#do_action('toggle_columns', 'mark:indent:icon:filename:type:size:time')
  nnoremap <silent><buffer><expr> >
  \ defx#do_action('resize', defx#get_context().winwidth + 5)
  nnoremap <silent><buffer><expr> <
  \ defx#do_action('resize', defx#get_context().winwidth - 5)

	call defx#custom#column('icon', {
	      \ 'directory_icon': '▸',
	      \ 'opened_icon': '▾',
	      \ 'root_icon': ' ',
	      \ })

	call defx#custom#column('filename', {
	      \ 'min_width': 40,
	      \ 'max_width': 40,
	      \ })

	call defx#custom#column('mark', {
	      \ 'readonly_icon': '✗',
	      \ 'selected_icon': '✓',
	      \ })
endfunction
"}}}
" easy-motion settings ---{{{
" reset default leader from <leader><leader> to something else
" should try not to use this, since it is not really improving productivity
map <leader>q <Plug>(easymotion-prefix)
" <Leader>f{char} to move to {char}
map  <Leader>s <Plug>(easymotion-bd-f)
nmap <Leader>s <Plug>(easymotion-overwin-f)
" s{char}{char} to move to {char}{char} across pane
nmap f <Plug>(easymotion-overwin-f2)
" t{char}{char} to move to <cursor>{char}{char} in the same pane
nmap t <Plug>(easymotion-t2)
" n-char search motion in the same pane
map  <leader>/ <Plug>(easymotion-sn)
omap <leader>/ <Plug>(easymotion-tn)
"}}}
" Signify settings --{{{
" Potential improvements: support the feature for split panes
" Currently panes on the side cannot have signs added
" sadly the signs are covered by ALE oens :(
" default updatetime 4000ms is not good for async update
set updatetime=100
let g:signify_disable_by_default = 1
nnoremap <leader>ts :SignifyToggle<cr>
"}}}

colorscheme gruvbox
let g:gruvbox_contrast_dark = 'soft'
let g:grovbox_contrast_light = 'soft'
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
