function FixupBase16(info)
    !sed -i '/Base16hi/\! s/a:\(attr\|guisp\)/l:\1/g' ~/.vim/plugged/base16-vim/colors/*.vim
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUG https://github.com/junegunn/vim-plug
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.dotfiles/vim/plugged')
" Editor Wide
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'Raimondi/delimitMate'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-fugitive'
Plug 'ntpeters/vim-better-whitespace'
Plug 'embear/vim-localvimrc'
Plug 'vim-scripts/a.vim' " Header/Impl file jumping
Plug 'chriskempson/base16-vim', { 'do': function('FixupBase16') }
Plug 'vim-airline/vim-airline'
" Airline themes have been split into their own repo
Plug 'vim-airline/vim-airline-themes'

" Language Assistance
Plug 'mattn/emmet-vim'
Plug 'pangloss/vim-javascript', { 'for': ['javascript'] }
Plug 'leafgarland/typescript-vim'
Plug 'mxw/vim-jsx', { 'for': ['javascript'] }
"Plug 'kchmck/vim-coffee-script', { 'for': ['coffee'] }
"Plug 'dag/vim2hs', { 'for': ['haskell'] }
Plug 'vim-ruby/vim-ruby', { 'for': ['ruby'] }
"Plug 'plasticboy/vim-markdown', { 'for': ['markdown'] }
"Plug 'mustache/vim-mustache-handlebars', { 'for': ['html.handlebars'] }
Plug 'rust-lang/rust.vim', { 'for': ['rust'] }
Plug 'fatih/vim-go', { 'for': ['go'] }
call plug#end()
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Force 256 color for terminal usage
set t_Co=256
set background=dark
let base16colorspace=256
colorscheme base16-eighties

" Encoding settings
scriptencoding utf-8
set encoding=utf-8

imap kj <Esc>
let mapleader=','
set bs=2

"set cursorline
set ruler
set list
set listchars=tab:`\ ,eol:¬
hi NonText ctermfg=gray
hi SpecialKey ctermfg=gray
set wrap!
set number

"set colorcolumn=80

"Search
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch

" Default tab options
set tabstop=2 softtabstop=2 shiftwidth=2 expandtab
au FileType python set autoindent
au FileType rust set tabstop=2 softtabstop=2 shiftwidth=2 expandtab

" No swaps!
set noswapfile

" GUI options

set guifont=Terminus\ 11

set guioptions-=m "remove menu bar
set guioptions-=T "remove toolbar
set guioptions-=r "remove right-hand scroll bar
set guioptions-=L "remove left-hand scroll bar
hi Visual guibg=#444444
hi MatchParen cterm=bold ctermfg=black ctermbg=yellow

"" Kill annoying error bells
set noerrorbells visualbell t_vb=
autocmd! GUIEnter * set visualbell t_vb=

set nowritebackup
set clipboard=unnamed

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Custom Keybinds
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Switching panes
nmap <leader>wh <C-w><left>
nmap <leader>wj <C-w><down>
nmap <leader>wk <C-w><up>
nmap <leader>wl <C-w><right>

" Resizing panes
nmap <leader>j :resize -4<CR>
nmap <leader><leader>j :resize -16<CR>
nmap <leader>k :resize +4<CR>
nmap <leader><leader>k :resize +16<CR>
nmap <leader>h :vertical resize +4<CR>
nmap <leader><leader>h :vertical resize +16<CR>
nmap <leader>l :vertical resize -4<CR>
nmap <leader><leader>l :vertical resize -16<CR>

vmap <leader>c "+y<CR>
nmap <leader>v "+gP<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin options
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leader>ne :NERDTree<CR>
nmap <leader>t :CtrlP<CR>
nmap <leader>sw :StripWhitespace<CR>
let g:user_emmet_leader_key='<C-k>'

"ctrlp ignore
set wildignore+=*/node_modules/*,*/fusor-ember-cli/tmp/*,*/fusor-ember-cli/dist/*,*/vendor/*

"let NERDTreeDirArrows=0

" Airline options
let g:airline#extensions#branch#enabled = 1
set laststatus=2

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" react
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"let g:jsx_ext_required = 0
"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" js
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
hi link javaScriptTemplateDelim String
hi link javaScriptTemplateVar Text
hi link javaScriptTemplateString String

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" golang
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Way the go.vim default syntax file was written, it requires
" the highlight trailing whitespace error to be defined in the
" vimrc file, unfortunately. It _cannot_ be defined in ftplugin
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Keybinds
"autocmd BufWritePost *.go normal! zv
nmap <leader>gd :GoDef<CR>
nmap <leader>gdd :GoDefPop<CR>
nmap <leader>gds :GoDefStack<CR>
nmap <leader>gc :GoCallers<CR>
nmap <leader>gr :GoRename<CR>
inoremap <C-l> <C-x><C-o>
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
au FileType go set foldmethod=syntax foldlevel=99
let g:go_fmt_experimental = 1
let g:go_highlight_trailing_whitespace_error = 0
" For some reason I'm needing this so go#fmt#Format will not throw an error
" during save, default is:
set mmp=1000
"set mmp=2000

hi link javaScriptTemplateDelim String
hi link javaScriptTemplateVar Text
hi link javaScriptTemplateString String

" localvimrc
let g:localvimrc_ask = 0 " Don't ask when loading localvimrc
