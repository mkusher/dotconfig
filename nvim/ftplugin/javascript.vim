set tabstop=4
set shiftwidth=4
set expandtab
set autoindent		"always set autoindenting on
set smarttab
set smartindent

function! RunShellCommandInNewBuffer(commandStr)
    bo new
    setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap nonumber syntax=bash
    silent exe a:commandStr
    AnsiEsc
    setlocal nomodifiable
endfunction

function! RunNpmUnitTests()
    let commandStr = 'r ! npm run unit-tests'
    echo "Started unit tests"
    call RunShellCommandInNewBuffer(commandStr)
endfunction

function! RunNpmUnitTest()
    let commandStr = 'r ! npm run unit-tests -- ' . @%
    echo "Started unit test"
    call RunShellCommandInNewBuffer(commandStr)
endfunction

function! RunNpmUITests()
    let commandStr = 'r ! npm run e2e-tests'
    echo "Started e2e tests"
    call RunShellCommandInNewBuffer(commandStr)
endfunction

function! RunNpmTests()
    let commandStr = 'r ! npm test'
    echo "Started npm tests"
    call RunShellCommandInNewBuffer(commandStr)
endfunction

map <F9> :call RunNpmUnitTest()<CR>
map <F10> :call RunNpmUnitTests()<CR>
map <F6> :call RunNpmUITests()<CR>
map <F5> :call RunNpmTests()<CR>

setlocal omnifunc=tsuquyomi#complete
