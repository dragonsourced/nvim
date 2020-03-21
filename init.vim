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

" For for most filetypes, use 4 spaces instead of tabs.

set et sw=4 sts=4

" Nice little setup for writing things.

fun! s:writing_mode()
    set spell formatoptions+=a
    Goyo
    PencilSoft
endfun

com! WritingMode call s:writing_mode()

autocmd BufRead,BufNewFile *.md WritingMode
autocmd BufRead,BufNewFile *.c,*.h,Makefile,*.mk,*.go set noet sw=8 sts=8

autocmd! User GoyoLeave nested quit

" Statusline stuff.

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

set statusline=%!g:Statusline()

" Keep the cursor centered.
set scrolloff=999

" Provides a nice 1-character gap between the text and the
" left side of the screen.
set foldcolumn=1

let g:gutentags_cache_dir = "~/.config/nvim/tags"

" Stuff for tabs

nnoremap <silent> <C-t> :tabnew<CR>
nnoremap <silent> <C-l> :tabnext<CR>
nnoremap <silent> <C-h> :tabprev<CR>
nnoremap <silent> <S-h> :-tabmove<CR>
nnoremap <silent> <S-l> :+tabmove<CR>

" Theme varies depending on the value of /tmp/theme, which I
" use in my other scripts. Also, instead of a standard ColorColumn I instead
" color everything past 80 characters.

let s:theme = system("cat /tmp/theme | tr -d '\n'")

if s:theme == "light" && $TERM != "linux"
    set background=light
    hi Colorcolumn ctermbg=255
else
    set background=dark
    hi Colorcolumn ctermbg=235
end

let &colorcolumn = join(range(81,999),",")

" Homebrewed snippets system.

fun g:EatChar()
    call getchar(0)
    startinsert
endfun

command -nargs=* Snip iabbrev <silent> <args><Esc>:call search("_", "b")<CR>x<Esc>:call g:EatChar()<CR>

fun s:load_snip()
    let s:snip_file = expand("~/.config/nvim/snip/" . &filetype . ".vim")
    if file_readable(s:snip_file)
        execute("source " . s:snip_file)
    end
endfun

command LoadSnippets call s:load_snip()

autocmd BufRead,BufNewFile * call s:load_snip()
