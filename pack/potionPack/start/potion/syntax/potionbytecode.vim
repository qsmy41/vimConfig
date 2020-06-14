
" highlight numbers
syntax match potionBytecodeNumber "\v([0-9])+"
highlight link potionBytecodeNumber Number

" highlight ^.valud, ^.local, etc.
syntax match potionBytecodeType "\v^\.([a-zA-Z])+" 
highlight link potionBytecodeType Type

" highlight strings after ^.value
syntax match pattern_before_string nextgroup=potionBytecodeString skipwhite 
            \ "\v\.([a-zA-Z])+\s((\S+\s+)+;\s([0-9]+)+)@!"
syntax match potionBytecodeString "\v.+$" contained
highlight! link pattern_before_string potionBytecodeType
highlight! link potionBytecodeString String
" the following doesn't work because it contains another matched syntax group
" i.e. potionBytecodeType
" syntax match String "\v\.[a-zA-Z]+\s\zs<(\S+>\s;\s[0-9]+)@!.*\ze$"

" highlight the strings in "xxx"

" highlight getupval, getlocal, etc.
syntax match potionBytecodeKeyword "\v\]\s\zs[a-zA-Z]+\ze\s+[0-9]+"
highlight link potionBytecodeKeyword Keyword

" highlight "preprocesses", the large chunk at the start of the file
syntax match potionBytecodePreProc "\v^(\.|(\s*;)|\[|\*\*)@!\zs.*\ze$"
highlight link potionBytecodePreProc PreProc

" highlight comments starting with **
syntax match potionBytecodeComment "\v^\*\*.*"
highlight link potionBytecodeComment Comment
