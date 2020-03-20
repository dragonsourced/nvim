call plug#begin()

Plug 'dragonsourced/simple.vim'

Plug 'dense-analysis/ale'
Plug 'tpope/vim-fugitive'

Plug 'junegunn/goyo.vim'

Plug 'ajh17/VimCompletesMe'
Plug 'ludovicchabant/vim-gutentags'

Plug 'ryanoasis/vim-devicons'

call plug#end()

set clipboard+=unnamedplus
colorscheme simple

set et sw=4 sts=4

fun! s:writing_mode()
    set spell formatoptions+=a
    Goyo
endfun

com! WritingMode call s:writing_mode()

autocmd BufRead,BufNewFile *.md WritingMode
autocmd BufRead,BufNewFile *.c,*.h,Makefile,*.mk,*.go set noet sw=8 sts=8

autocmd! User GoyoLeave nested quit

if executable('black')
    autocmd BufWritePost *.py silent execute "!black %" | edit
end

function! g:FileType()
    if $WINDOWID == ""
        return "[" . &filetype . "]"
    else
        return WebDevIconsGetFileTypeSymbol()
    end
endfunction

function! g:Statusline()
    return " %f%m (%l/%L) %= %{gutentags#statusline()} %{toupper(&encoding)} %{FileType()} "
endfunction

set statusline=%!g:Statusline()
set scrolloff=999
set fdc=1

let g:gutentags_cache_dir = "~/.config/nvim/tags"

nnoremap <silent> <C-t> :tabnew<CR>
nnoremap <silent> <C-l> :tabnext<CR>
nnoremap <silent> <C-h> :tabprev<CR>
nnoremap <silent> <S-h> :-tabmove<CR>
nnoremap <silent> <S-l> :+tabmove<CR>
