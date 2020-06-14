" the starting if statement and the buffer variable at the end
" act as a "guard" to prevent this script from running twice or more.
if exists("b:current_syntax")
    finish
endif

syntax keyword potionKeyword loop times to while
syntax keyword potionKeyword if elsif else
syntax keyword potionKeyword class return
highlight link potionKeyword Keyword

syntax keyword potionFunction print join string
highlight link potionFunction Function

syntax match potionComment "\v#.*$"
highlight link potionComment Comment

syntax match potionOperator "\v\*"
syntax match potionOperator "\v/"
syntax match potionOperator "\v\+"
" The following two operators should be placed before -=
" otherwise only - or = would be highlighted
syntax match potionOperator "\v-"
syntax match potionOperator "\v\="
syntax match potionOperator "\v\?"
syntax match potionOperator "\v\*\="
syntax match potionOperator "\v/\="
syntax match potionOperator "\v\+\="
syntax match potionOperator "\v-\="
highlight link potionOperator Operator

syntax match potionNumber "\v(0x)?0?([0-9])+"
highlight link potionNumber Number

syntax match potionFloat "\v([0-9])+\.([0-9])+(e(\+|\-)?([0-9])+)?"
highlight link potionFloat Float

" syntax match potionString "\v'.*'"
" syntax match potionString "\v\".*\""
" highlight link potionString String
syntax region potionString start=/\v"/ skip=/\v\\./ end=/\v"/
highlight link potionString String

" "contains" allow the specific syntax group to begin inside the item
" "contained" indicates that the syntax group cannot be recognized at the top
" level
" "matchgroup" is used to highlight the "start" &/or "end" pattern differently
" than the body of the region
" sy region par1 matchgroup=par1 start=/(/ end=/)/ contains=par2
" sy region par2 matchgroup=par2 start=/(/ end=/)/ contains=par3 contained
" sy region par3 matchgroup=par3 start=/(/ end=/)/ contains=par1 contained
" hi par1 ctermfg=red guifg=red
" hi par2 ctermfg=blue guifg=blue
" hi par3 ctermfg=darkgreen guifg=darkgreen

let b:current_syntax = "potion"
