set tabstop=2
set shiftwidth=2
let g:neomake_typescript_enabled_makers = ['tsc', 'tslint']
"let g:tsuquyomi_disable_quickfix = 1
let g:neoformat_enabled_typescript = ['prettier']
let g:ale_linters['typescript'] = ['tsserver']


"set ballooneval
"autocmd FileType typescript setlocal balloonexpr=tsuquyomi#balloonexpr()

nmap <buffer> <Leader>t :TSType<CR>
nmap <buffer> <Leader>rn :TSRename<CR>
nmap <buffer> <Leader>i :TSImport<CR>
nmap <buffer> g] :TSTypeDef<CR>
nmap <buffer> gd :TSDef<CR>

nmap <buffer> <Leader>ss :call specs#go_to_spec()<CR>

augroup fmt
  autocmd!
  autocmd FileType typescript BufWritePre * Neoformat
augroup END
