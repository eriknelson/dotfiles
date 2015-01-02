call pathogen#infect()
call pathogen#helptags()

" Force 256 color for terminal usage
set t_Co=256
colorscheme Tomorrow-Night

" Encoding settings
scriptencoding utf-8
set encoding=utf-8

filetype plugin indent on
syntax on

imap kj <Esc>
let mapleader=','
set bs=2

"set cursorline
set ruler
set list
set listchars=tab:`\ ,eol:¬
"set listchars=tab:→\ ,eol:¬
"set listchars=tab:\|\ ,eol:¬
hi NonText ctermfg=gray
hi SpecialKey ctermfg=gray
set wrap!
set number

"Search
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch

" Default tab options
set tabstop=2 softtabstop=2 shiftwidth=2 expandtab

" GUI options
set guifont=Inconsolata\ 12
set guioptions-=m "remove menu bar
set guioptions-=T "remove toolbar
set guioptions-=r "remove right-hand scroll bar
set guioptions-=L "remove left-hand scroll bar
hi Visual guibg=#444444
hi MatchParen cterm=bold ctermfg=black ctermbg=yellow

" Kill annoying error bells
set noerrorbells
set novisualbell
set t_vb=
autocmd! GUIEnter * set vb t_vb=

" Plugin options
nmap <leader>ne :NERDTree<CR>
nmap <leader>t :CtrlP<CR>
nmap <leader>sw :StripWhitespace<CR>
let g:user_emmet_leader_key='<C-k>'
"let NERDTreeDirArrows=0

" Airline options
let g:airline#extensions#branch#enabled = 1
set laststatus=2

" Rust dev
let g:rust_recommended_style=0
set hidden
let g:racer_cmd="/Users/nelson/.vim/bundle/racer/bin/racer"
"let $RUST_SRC_PATH="/Users/nelson/dev/rust/rust/src"

" Custom funcs
" =============== Window swap ================
function! MarkWindowSwap()
  let g:markedWinNum = winnr()
endfunction

function! DoWindowSwap()
  "Mark destination
  let curNum = winnr()
  let curBuf = bufnr( "%" )
  exe g:markedWinNum . "wincmd w"
  "Switch to source and shuffle dest->source
  let markedBuf = bufnr( "%" )
  "Hide and open so that we aren't prompted and keep history
  exe 'hide buf' curBuf
  "Switch to dest and shuffle source->dest
  exe curNum . "wincmd w"
  "Hide and open so that we aren't prompted and keep history
  exe 'hide buf' markedBuf
endfunction

nmap <silent> <leader>mw :call MarkWindowSwap()<CR>
nmap <silent> <leader>pw :call DoWindowSwap()<CR>

" a better htmldjango detection
augroup filetypedetect
  " removes current htmldjango detection located at $VIMRUNTIME/filetype.vim
  au! BufNewFile,BufRead *.html
  au BufNewFile,BufRead *.html call FThtml()

  func! FThtml()
    let n = 1
    while n < 10 && n < line("$")
      if getline(n) =~ '\<DTD\s\+XHTML\s'
        setf xhtml
        return
      endif
      if getline(n) =~ '{%\|{{\|{#'
        setf htmldjango
        return
      endif
      let n = n + 1
    endwhile
    setf html
  endfunc
augroup END

set nowritebackup
set clipboard=unnamed

" Autocompletion
" See:
" http://vim.wikia.com/wiki/Make_Vim_completion_popup_menu_work_just_like_in_an_IDE
set completeopt=longest,menuone
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Bind autocomplete to C-Space
inoremap <C-Space> <C-x><C-o>
inoremap <C-@> <C-Space>

"inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
  "\ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
"inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
  "\ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
