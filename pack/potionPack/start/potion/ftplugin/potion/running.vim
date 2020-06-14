" This is a common pattern you'll see in Vim plugins:
" most of their functionality will be held in autoloaded functions,
" with just nnoremap and command commands in the files 
" that Vim loads every time.
" Keep it in mind whenever you're writing a non-trivial Vim plugin.

if !exists("g:potion_command")
    " this allows the user to set their own path to potion in .vimrc
    " in this case, in the IC lab machine, ~/Documents/vim/potion/bin/potion
    " if this is alr set, having the if statements will not take any effect
    " only after "unlet" the g:potion_command can then be reset
    " so here just remove the if statements
    " or set in .vimrc and source it
    let g:potion_command = "~/Documents/vim/potion/bin/potion"
endif

if !exists("g:potion_bytecode_split")
    let g:potion_bytecode_split = "sp"
endif

nnoremap <buffer> <localleader>r 
            \ :call potion#running#PotionCompileAndRunFile()<cr>

nnoremap <buffer> <localleader>b 
            \ :call potion#running#PotionShowBytecode()<cr>
