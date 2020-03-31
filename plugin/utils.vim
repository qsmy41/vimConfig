" CharIsDigit(c) --- Check if c is a digit ---{{{
function! CharIsDigit(c)
    return a:c ==# '0'
                \ || a:c ==# '1'
                \ || a:c ==# '2'
                \ || a:c ==# '3'
                \ || a:c ==# '4'
                \ || a:c ==# '5'
                \ || a:c ==# '6'
                \ || a:c ==# '7'
                \ || a:c ==# '8'
                \ || a:c ==# '9'
endfunction
"}}}

