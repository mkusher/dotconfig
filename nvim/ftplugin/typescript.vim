"let g:ycm_filetype_specific_completion_to_disable.typescript = 1
"let g:syntastic_typescript_tsc_args = '-t ES6'

let g:neomake_typescript_enabled_makers = []
let g:syntastic_typescript_checkers = ['tsuquyomi']
let g:tsuquyomi_disable_quickfix = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1

"set ballooneval
"autocmd FileType typescript setlocal balloonexpr=tsuquyomi#balloonexpr()

nmap <buffer> <Leader>t : <C-u>echo tsuquyomi#hint()<CR>
nmap <buffer> <Leader>s :TsuRenameSymbol<CR>
