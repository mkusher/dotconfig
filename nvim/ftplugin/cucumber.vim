
function! RunNpmUITest()
    let commandStr = 'r ! npm run e2e-tests -- --specs=' . @%
    echo "Started e2e test"
    bo new
    setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap nonumber
    silent exe commandStr 
    AnsiEsc
    setlocal nomodifiable
endfunction

map <F7> :call RunNpmUITest()<CR>
