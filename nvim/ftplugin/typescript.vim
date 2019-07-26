set tabstop=2
set shiftwidth=2
let g:neomake_typescript_enabled_makers = ['tsc', 'eslint']
"let g:tsuquyomi_disable_quickfix = 1
let g:neoformat_enabled_typescript = ['prettier']
let g:ale_linters['typescript'] = ['tsserver']


nmap <buffer> <Leader>t :call CocAction("doHover")<CR>
nmap <buffer> <Leader>rn :TSRename<CR>
nmap <buffer> <Leader>i :CocFix<CR>
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nmap <buffer> <Leader>ss :call specs#go_to_spec()<CR>
