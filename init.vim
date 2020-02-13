" Automatically install vim-plug.

if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
          \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins to install.

call plug#begin()

" Recursion is fun.
Plug 'junegunn/vim-plug'

Plug 'dense-analysis/ale'
Plug 'tpope/vim-fugitive'
Plug 'fatih/vim-go'

Plug 'shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

Plug 'dragonsourced/simple.vim'

call plug#end()

" Use 4 spaces instead of tabs for all filetypes except C and Golang.

set clipboard+=unnamedplus
set si et sw=4

autocmd BufRead,BufNewFile *.go,*.c,*.h set noet sw=8

" Past 1600 hours (4 pm) or in a TTY, use the dark theme.
" Otherwise, use light.

let s:hr = (strftime("%H"))

if $TERM == "linux" || s:hr >= 16
    set bg=dark
else
    set bg=light
end

" A nice, barebones colorscheme.

colorscheme simple

" Autocompletion should be default, yes.

let g:deoplete#enable_at_startup = 1

" <Tab> autocompletes.

inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
