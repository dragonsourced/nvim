call plug#begin()

Plug 'dense-analysis/ale'
Plug 'tpope/vim-fugitive'
Plug 'fatih/vim-go'

call plug#end()

set clipboard+=unnamedplus
set si et sw=4

autocmd BufRead,BufNewFile *.go,*.c,*.h set noet sw=8

let s:hr = (strftime("%H"))

" Past 1600 hours (4 pm) or in a TTY, use the dark theme.
" Otherwise, use light.

if $TERM == "linux" || s:hr >= 16
    set bg=dark
else
    set bg=light
end

colorscheme simple
