set tabstop=2
set shiftwidth=2
let g:neomake_typescript_enabled_makers = ['eslint']
"let g:tsuquyomi_disable_quickfix = 1
let g:neoformat_enabled_typescript = ['prettier']

nmap <buffer> <Leader>ss :call specs#go_to_spec()<CR>
