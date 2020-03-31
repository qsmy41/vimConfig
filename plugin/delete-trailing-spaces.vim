nnoremap <leader>ds :call <SID>deleteTrailingSpaces()<cr>

function! s:deleteTrailingSpaces()
    let l:originalSearchPattern = @/
    " mark and variable to retain the original state
    normal! mq
    let @/ = '\S\zs\s\+$'
    let l:matchesCommand = "%s/" . @/ . "//n"

    try
        " execute and obtain the statement about matches
        redir @q
        silent execute matchesCommand
        redir END
        
        " use the first char to determine if the search hits bottom
        " @q[0] is ' ', the first char is ACTUALLY @q[1]
        " grep the following function in ~/.vim/plugin for more details
        while CharIsDigit(@q[1])
            normal! nD
            " if it is the last match deleted,
            " i.e. 1 match on 1 line,
            if @q[1:2] ==# "1 "
                break
            endif
            redir @q
            silent execute matchesCommand
            redir END
        endwhile
    finally
        let @/ = l:originalSearchPattern
        normal! `q
        echo "No trailing whitespaces left."
        return
    endtry

endfunction
