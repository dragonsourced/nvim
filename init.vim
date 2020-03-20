call plug#begin()

Plug 'dragonsourced/simple.vim'

Plug 'dense-analysis/ale'
Plug 'tpope/vim-fugitive'

Plug 'ajh17/VimCompletesMe'
Plug 'ludovicchabant/vim-gutentags'

Plug 'ryanoasis/vim-devicons'

call plug#end()

set clipboard+=unnamedplus
colorscheme simple

set et sw=4 sts=4

autocmd BufRead,BufNewFile *.c,*.h,Makefile,*.mk,*.go set noet sw=8 sts=8

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
    return "%f%m (%l/%L) %= %{gutentags#statusline()} %c %{FileType()} "
endfunction

set statusline=%!g:Statusline()
set scrolloff=999

let g:gutentags_cache_dir = "~/.config/nvim/tags"

nnoremap <silent> <C-t> :tabnew<CR>
nnoremap <silent> <C-l> :tabnext<CR>
nnoremap <silent> <C-h> :tabprev<CR>
nnoremap <silent> <S-h> :-tabmove<CR>
nnoremap <silent> <S-l> :+tabmove<CR>
