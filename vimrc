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
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'takac/vim-hardtime'
Plug 'tpope/vim-commentary'
Plug 'mattn/emmet-vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

command! -nargs=0 Prettier :CocCommand prettier.formatFile

let g:user_emmet_leader_key='<C-e>'

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

" \dq : surround with double quotes
nmap <Leader>dq yss"<CR>

" NerdTREE next tab
nnoremap <Leader>- :tabn<CR>

" Set internal encoding of vim, not needed on neovim, since coc.nvim using some
" unicode characters in the file autoload/float.vim
set encoding=utf-8

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

let g:coc_global_extensions = [
      \ 'coc-tsserver',
      \ 'coc-html',
      \ 'coc-css',
      \ 'coc-yaml',
      \ 'coc-json',
      \ 'coc-vimlsp',
      \ 'coc-emmet',
      \ 'coc-prettier',
      \ 'coc-vetur',
      \ ]

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

inoremap <expr> <Tab> pumvisible() ? coc#_select_confirm() : "<Tab>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
"
" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)
"
"
" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')


let g:solarized_termtrans=1
colorscheme solarized
filetype on



