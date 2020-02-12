" simple.vim
"
" A colorscheme, I guess.
"
" Emphasizes comments and strings, and nothing else.
"

hi clear
let g:colors_name = "simple"

" Checks for 256color support.
"
" I don't know how to do this 'properly' so I just assume it to be
" the case everywhere except for TTYs.

if $TERM ==# "linux"
    let s:gui = 0
else
    let s:gui = 1
end

" Normal text shouldn't be styled at all. Ever.
"
" Unless you're some kind of masochist, in which case go ahead! Color your
" text lime green on a bright magenta background, turn your screen into a damn
" memetic kill agent, infiltrate the NSA and install your monstrous creation
" on all their systems.
"
" Just keep it the hell away from me.

hi clear Normal

" Hides the post-buffer tildes.
" Disable with `let g:simple#hide_tildes = 0` before loading the colorscheme.

if !exists(g:simple#hide_tildes)
    let g:simple#hide_tildes = 1
end

if &background == "light"
    hi EndOfBuffer ctermfg=white
else
    hi EndOfBuffer ctermfg=black
end

" Do you really need colors to tell these apart? Really?

hi clear Identifier
hi clear SpecialKey
hi clear Statement

hi clear Type
hi clear PreProc
hi clear Constant
hi clear Special

hi clear NonText

" Emphasize comments and strings, as promised up above.

hi clear Comment
hi clear String
hi Comment cterm=bold gui=bold
hi String  cterm=bold gui=bold
