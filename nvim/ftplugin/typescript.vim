let g:neomake_typescript_enabled_makers = ['tslint']
"let g:syntastic_typescript_checkers = ['tsuquyomi']
let g:neomake_typescript_tsc_maker = {
            \ 'args': [
            \ '-m', 'system', '--noEmit', '--jsx', 'preserve', '-t', 'ES6',
            \ '--moduleResolution', 'classic', '--isolatedModules',
            \ '--experimentalDecorators', '--noImplicitAny'
            \ ],
            \ 'errorformat':
            \ '%E%f %#(%l\,%c): error %m,' .
            \ '%E%f %#(%l\,%c): %m,' .
            \ '%Eerror %m,' .
            \ '%C%\s%\+%m'
            \ }
let g:tsuquyomi_disable_quickfix = 1

"set ballooneval
"autocmd FileType typescript setlocal balloonexpr=tsuquyomi#balloonexpr()

nmap <buffer> <Leader>t : <C-u>echo tsuquyomi#hint()<CR>
nmap <buffer> <Leader>rn :TsuRenameSymbol<CR>
nmap <buffer> <Leader>i :TsuImport<CR>
nmap <buffer> g] :TsuDefinition<CR>

nmap <buffer> <Leader>ss :call specs#go_to_spec()<CR>
