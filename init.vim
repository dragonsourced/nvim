call plug#begin()

Plug 'dragonsourced/simple.vim'

Plug 'dense-analysis/ale'
Plug 'tpope/vim-fugitive'

Plug 'Shougo/deoplete.nvim', { 'do' : ':UpdateRemotePlugins' }
Plug 'deoplete-plugins/deoplete-jedi'

Plug 'reedes/vim-pencil'
Plug 'junegunn/goyo.vim'

call plug#end()

set clipboard+=unnamedplus
colorscheme simple

let g:deoplete#enable_at_startup = 1
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

set et sw=4 sts=4

function s:write_mode()
    PencilSoft
    Goyo
endfunction

autocmd BufRead,BufNewFile *.md call s:write_mode()
autocmd BufRead,BufNewFile *.c,*.h,Makefile,*.mk,*.go set noet sw=8 sts=8

if executable('black')
    autocmd BufWritePost *.py silent execute "!black %" | edit
end
