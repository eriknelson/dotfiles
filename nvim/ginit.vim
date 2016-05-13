command! -nargs=? Guifont call rpcnotify(0, 'Gui', 'SetFont', "<args>") | let g:Guifont="<args>"
Guifont Terminus:h14
