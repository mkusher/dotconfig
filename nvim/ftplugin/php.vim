set tabstop=4
set shiftwidth=4
set expandtab
set autoindent		" always set autoindenting on
set smarttab
set smartindent

"let g:SuperTabDefaultCompletionType = "<c-x><c-o>"

"nnoremap <Leader>l :Unite padawan/classes -start-insert<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
set completefunc=LanguageClient#complete
autocmd FileType php LanguageClientStart
