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
Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'othree/html5.vim'
Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
Plug 'takac/vim-hardtime'
Plug 'tpope/vim-commentary'

call plug#end()

" Setup vim with ag instead of find
let $FZF_DEFAULT_COMMAND = 'ag -l -g ""'

" Open fzf in current window instead of new
let g:fzf_layout = { 'window': 'enew' }
let g:hardtime_default_on = 1
let g:list_of_disabled_keys = ['<UP>', '<DOWN>', '<LEFT>', '<RIGHT>']

filetype plugin indent on
autocmd ColorScheme * highlight TrailingWhitespace ctermbg=red guibg=red
au InsertEnter * match TrailingWhitespace /\s\+\%#\@<!$/
au InsertLeave * match TrailingWhitespace /\s\+$/
au BufWinEnter * match TrailingWhitespace /\s\+$/

au BufNewFile,BufRead *.rs set filetype=rust
au BufNewFile,BufRead *.dart set filetype=dart
au BufNewFile,BufRead *.psgi set filetype=perl
au BufNewFile,BufRead *.scala set filetype=scala
au BufNewFile,BufRead *.vue set filetype=vue
au BufNewFile,BufRead *.mjml set filetype=html

set tabstop=2 sts=2 shiftwidth=2 expandtab shiftround smarttab

autocmd Filetype perl setlocal ts=4 sts=4 sw=4 expandtab smarttab

let loaded_matchparen=1

set autoindent smartindent showmatch
set noincsearch nobackup nocindent hlsearch visualbell
set indentexpr=""
set formatoptions=""
set scrolloff=3
set tabpagemax=666
set confirm
set errorfile=.vimerrors.err

let g:user_emmet_leader_key='<C-l>'

inoremap jj <ESC>
nmap <leader>i mzgg=G`z

" \bn: next bufexplorer file
vnoremap <Leader>cp :w !pbcopy<CR><CR>

" \bn: next bufexplorer file
nnoremap <Leader>bn :bnext<CR>

" \bp: prev bufexplorer file
nnoremap <Leader>bp :bprev<CR>

" \bb: select file in bufexplorer window
nnoremap <Leader>bb :n#

" \a : search files in current directory using Ag
nnoremap <Leader>a :Ag<SPACE>

" \f : search files in current directory using fzf
nnoremap <Leader>f :Files<CR>

" \tt : switch to tt2 syntax
nnoremap <Leader>tt :set syntax=tt2<CR>

" \dp : insert Data::Printer line
nnoremap <Leader>dp ouse Data::Printer; p<SPACE>

" \pp Toggle :set paste
nnoremap <Leader>pp :set paste!<CR>

" \S : delete all trailing whitespace
nnoremap <Leader>S :%s/\s\+$//<CR>

" \ds: convert double to single quotes
nmap <Leader>ds cs"'<CR>

" \sd : convert single to double quotes
nmap <Leader>sd cs'"<CR>

" \sq : surround with single quotes
nmap <Leader>sq yss'<CR>

" \c : comment visualblock
vnoremap <Leader>c :s/^/# /"<CR><CR>

" \dq : surround with double quotes
nmap <Leader>dq yss"<CR>

" NerdTREE next tab
nnoremap <Leader>- :tabn<CR>

let g:solarized_termtrans=1
colorscheme solarized
filetype on
