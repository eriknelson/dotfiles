""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SETTINGS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Doesn't look like UTF-8 settings are required with neovim
syntax on
filetype plugin indent on

set ruler
set number
set wrap!

set list " NOTE: Required for whitespace chars
set listchars=tab:`\ ,eol:¬

" Default editor spacing settings
set tabstop=2 softtabstop=2 shiftwidth=2 expandtab

set noswapfile

" Search
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" KEYBINDS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
imap kj  <Esc>
let mapleader=','

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" DISPLAY
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set t_Co=256
set background=dark
let base16colorspace=256
colorscheme base16-eighties

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CURSORLINES
" Still performs horribly, esp. on ruby files :/
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" set re=1
" IMPORTANT FOR CURSOR{LINE,COLUMN}
" Forces use of the old regex engine, which is faster and
" prevents horrendous delay
"set re=1
"au WinLeave * set nocursorline nocursorcolumn
"au WinEnter * set cursorline cursorcolumn
"set cursorline cursorcolumn
"set colorcolumn=80
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" GUI Settings
command! -nargs=? Guifont call rpcnotify(0, 'Gui', 'SetFont', "<args>") | let g:Guifont="<args>"
Guifont Source\ Code\ Pro:h11

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUG START
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin()
Plug 'chriskempson/base16-vim'
call plug#end()
nmap <leader>r :source $HOME/.config/nvim/init.vim<CR>

