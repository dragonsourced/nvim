call plug#begin()

Plug 'dragonsourced/simple.vim'

Plug 'dense-analysis/ale'
Plug 'tpope/vim-fugitive'

Plug 'Shougo/deoplete.nvim', { 'do' : ':UpdateRemotePlugins' }
Plug 'deoplete-plugins/deoplete-jedi'

call plug#end()

set clipboard+=unnamedplus
colorscheme simple

let g:deoplete#enable_at_startup = 1
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

set et sw=4

autocmd BufRead,BufNewFile *.c,*.h,Makefile,*.mk set noet sw=8

if executable('black')
    autocmd BufWritePost *.py silent execute "!black %" | edit
end
