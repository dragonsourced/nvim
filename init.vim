call plug#begin()

Plug 'dragonsourced/simple.vim'

Plug 'dense-analysis/ale'
Plug 'tpope/vim-fugitive'

Plug 'junegunn/goyo.vim'
Plug 'reedes/vim-pencil'

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
    PencilSoft
endfun

com! WritingMode call s:writing_mode()

autocmd BufRead,BufNewFile *.md WritingMode
autocmd BufRead,BufNewFile *.c,*.h,Makefile,*.mk,*.go set noet sw=8 sts=8

autocmd! User GoyoLeave nested quit

if executable('black')
    autocmd BufWritePost *.py silent execute "!black %" | edit
end

fun! g:FileType()
    if $WINDOWID == ""
        return "[" . &filetype . "]"
    else
        return WebDevIconsGetFileTypeSymbol()
    end
endfun

let s:file_size = 0

autocmd BufRead,BufWritePost,BufNewFile * let s:file_size = getfsize(@%)

fun! g:FileSize()
    if s:file_size >= 500000000
        return string(floor((s:file_size/1000000000.0)*10)/10) . "G"
    elseif s:file_size >= 500000
        return string(floor((s:file_size/1000000.0)*10)/10) . "M"
    elseif s:file_size >= 500
        return string(floor((s:file_size/1000.0)*10)/10) . "K"
    else
        return string(s:file_size)
    end
endfun

fun! g:Statusline()
    return " %f%m (%l/%L) %= %{gutentags#statusline()} %{FileSize()} %{toupper(&encoding)} %{FileType()} "
endfun

set showtabline=2
set statusline=%!g:Statusline()
set scrolloff=999
set fdc=1

let g:gutentags_cache_dir = "~/.config/nvim/tags"

nnoremap <silent> <C-t> :tabnew<CR>
nnoremap <silent> <C-l> :tabnext<CR>
nnoremap <silent> <C-h> :tabprev<CR>
nnoremap <silent> <S-h> :-tabmove<CR>
nnoremap <silent> <S-l> :+tabmove<CR>

let s:theme = system("cat /tmp/theme | tr -d '\n'")

if s:theme == "light" && $TERM != "linux"
    set background=light
    hi Colorcolumn ctermbg=255
else
    set background=dark
    hi Colorcolumn ctermbg=235
end

let &colorcolumn = join(range(81,999),",")

command -nargs=* Snip iabbrev <silent> <args><Esc>:call search("_", "b")<CR>x<Left>i

Snip fori for (int i = 0; i < _; ++i)
