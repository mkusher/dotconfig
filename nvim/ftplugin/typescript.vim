set tabstop=2
set shiftwidth=2
let g:neomake_typescript_enabled_makers = ['tsc', 'tslint']
let g:neomake_typescript_tsc_maker = {
            \ 'args': [
            \ '--noEmit', '--jsx', 'preserve', '-t', 'ES6',
            \ '--moduleResolution', 'node', '--isolatedModules',
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
