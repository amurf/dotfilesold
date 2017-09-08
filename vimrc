set nocompatible               " be iMproved
filetype off                   " required!
syntax on

call plug#begin('~/.vim/plugged')

Plug 'vim-perl/vim-perl'
Plug 'altercation/vim-colors-solarized'
Plug 'vim-scripts/bufexplorer.zip'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-surround'
Plug 'guns/vim-clojure-static'
Plug 'guns/vim-clojure-highlight'
Plug 'posva/vim-vue'
Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'

call plug#end()

" Setup vim with ag instead of find
let $FZF_DEFAULT_COMMAND = 'ag -l -g ""'

" Open fzf in current window instead of new
let g:fzf_layout = { 'window': 'enew' }

filetype plugin indent on

autocmd ColorScheme * highlight TrailingWhitespace ctermbg=red guibg=red
au InsertEnter * match TrailingWhitespace /\s\+\%#\@<!$/
au InsertLeave * match TrailingWhitespace /\s\+$/
au BufWinEnter * match TrailingWhitespace /\s\+$/

au BufNewFile,BufRead *.rs set filetype=rust
au BufNewFile,BufRead *.dart set filetype=dart
au BufNewFile,BufRead *.psgi set filetype=perl
au BufNewFile,BufRead *.scala set filetype=scala

let loaded_matchparen=1

set autoindent showmatch
set noincsearch nobackup nocindent hlsearch visualbell
set indentexpr=""
set formatoptions=""
set scrolloff=3
set tabstop=4 shiftwidth=4 expandtab shiftround smarttab
set tabpagemax=666
set confirm
set errorfile=.vimerrors.err

nmap <leader>i mzgg=G`z

" \a : search files in current directory using fzf
nnoremap <Leader>a :Ag<SPACE>

" \f : search files in current directory using fzf
nnoremap <Leader>f :FZF<CR>

" \tt : switch to tt2 syntax
nnoremap <Leader>tt :set syntax=tt2<CR>

" \dp : insert Data::Printer line
nnoremap <Leader>dp ouse Data::Printer; p<SPACE>

" \pp Toggle :set paste
nnoremap <Leader>pp :set paste!<CR>

" \S : delete all trailing whitespace
nnoremap <Leader>S :%s/\s\+$//<CR>

" \ds: convert double to single quotes
nmap <Leader>ds cs"'

" \sd : convert single to double quotes
nmap <Leader>sd cs'"

" \sq : surround with single quotes
nmap <Leader>sq yss'

" \dq : surround with double quotes
nmap <Leader>dq yss"

" NerdTREE next tab
nnoremap <Leader>- :tabn<CR>

let g:solarized_termtrans=1
colorscheme solarized
filetype on
