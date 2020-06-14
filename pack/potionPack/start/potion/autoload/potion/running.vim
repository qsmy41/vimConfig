echom "Autoloading..."

function! potion#running#PotionCompileAndRunFile()
    silent !clear
    execute "!" . g:potion_command . " " . bufname("%")
endfunction

function! potion#running#PotionShowBytecode()
    " Get the bytecode.
    let bytecode = system(g:potion_command . " -c -V " . bufname("%"))
    
    " if split not opened, set it up
    " otherwise update the old split
    if bufwinnr("__Potion_Bytecode__") < 1
        execute g:potion_bytecode_split . " __Potion_Bytecode__"
    else
        execute (bufwinnr("__Potion_Bytecode__")) . "wincmd w"
    endif

    " subsequent times the same file name is reused, 
    " so need to clear the previous bytecodes
    normal! ggdG
    setlocal filetype=potionbytecode
    setlocal buftype=nofile
    
    " Insert the bytecode.
    call append(0, split(bytecode, '\v\n'))

endfunction
