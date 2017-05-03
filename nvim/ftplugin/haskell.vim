set tabstop=4
set shiftwidth=4
set expandtab
set autoindent		" always set autoindenting on
set smarttab
set smartindent

setlocal omnifunc=necoghc#omnifunc

let g:neoformat_haskell_enabled_formatters = ['hindent']

nmap <buffer> <Leader>t :GhcModType<CR>
