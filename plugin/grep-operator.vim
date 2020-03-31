nnoremap <leader>g :setlocal operatorfunc=<SID>GrepOperator<cr>g@
vnoremap <leader>g :<c-u>call <SID>GrepOperator(visualmode())<cr>

" '!' is required in front of :function to overwrite an existing function
" each of the two if runs:
" 1. visually select the text we want by:
"   - moving to the mark at the beginning of the range
"   - entering characterwise visual mode
"   - moving to the mark at the end of the range
" 2. yanking the visually selected text
function! s:GrepOperator(type)
    let saved_unnamed_register = @"

    if a:type ==# 'v'
        normal! `<v`>y
    elseif a:type ==# 'char'
        normal! `[y`]
    else
        return
    endif

    execute "grep! -R  " . shellescape(@") . " ."
    copen

    let @" = saved_unnamed_register
endfunction
