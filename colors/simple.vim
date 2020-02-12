" simple.vim
"
" A colorscheme, I guess.

hi clear
let g:colors_name = "simple"

if $TERM ==# "linux"
    let s:gui = 0
else
    let s:gui = 1
end

hi clear Normal

if &background == "light"
    hi EndOfBuffer ctermfg=white
else
    hi EndOfBuffer ctermfg=black
end

hi clear Identifier
hi clear SpecialKey
hi clear Statement
hi clear Comment

hi clear Type
hi clear PreProc
hi clear Constant

hi clear NonText

hi Comment cterm=bold gui=bold
hi String  cterm=bold gui=bold
