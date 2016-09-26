
if !exists('g:specs#command')
    let g:specs#command = "/home/mkusher/Projects/workarea/ehr/checkin/bin/mocha"
endif

function! specs#run(file)
    let command = [g:specs#command, a:file]
    let opts = {
                \ 'on_stdout': function("specs#handler"),
                \ 'on_stderr': function("specs#handler"),
                \ 'on_exit': function("specs#handler")
                \}
    echom join(command)
    echo "started tests"
    return jobstart(command, opts)
endfunction

function! specs#handler(code, data, event_type)
    if index(['stdout', 'stderr'], a:event_type) >= 0
        call function("specs#create_write_buffer")(join(a:data))
    endif
endfunction

function! specs#create_write_buffer(content)
    bo new
    setlocal modifiable
    put =a:content
    AnsiEsc
    setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap nonumber syntax=bash
    setlocal nomodifiable
endfunction

function! specs#go_to_spec()
python << ENDPYTHON
import vim
filepath = vim.eval("expand('%:p')")
filePart = filepath.split(".")
if "spec" in filePart:
    filePart = [ part for part in filePart if part != "spec" ]
else:
    extension = filePart.pop()
    filePart.append("spec")
    filePart.append(extension)

filepath = ".".join(filePart)
vim.command("execute \"e {0}\"".format(filepath))
ENDPYTHON
endfunction
