set tabstop=2
set shiftwidth=2
set expandtab
set autoindent		"always set autoindenting on
set smarttab
set smartindent

nmap <buffer> <Leader>ss :call specs#go_to_spec()<CR>
let g:neoformat_enabled_javascript = ['prettier']
let g:neomake_javascript_enabled_makers = ['eslint', 'flow']

nmap <F5> :! npm run build<CR>
nmap <buffer> <Leader>t :TSType<CR>
nmap <buffer> <Leader>rn :TSRename<CR>
nmap <buffer> <Leader>i :TSImport<CR>
