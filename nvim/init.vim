" Defaults {{{
" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
"set nocompatible
"set encoding=cp1251
set autoread
set fileencodings=utf-8,cp1251,koi8-r,cp866
set wildignore+=node_modules/*
set wildignore+=bower_components/*
set wildignore+=typings/*
set wildignore+=cache/*
set wildignore+=vendor/*

" Enable file type detection.
" Use the default filetype settings, so that mail gets 'tw' set to 72,
" 'cindent' is on in C files, etc.
" Also load indent files, to automatically do language-dependent indenting.
filetype plugin indent on

" Put these in an autocmd group, so that we can delete them easily.
augroup vimrcEx
    au!

    " For all text files set 'textwidth' to 78 characters.
    autocmd FileType text setlocal textwidth=78

    " Trim spaces when saving file
    autocmd BufWritePre * :%s/\s\+$//e

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim).
    " Also don't do it when the mark is in the first line, that is the default
    " position when opening a file.
    autocmd BufReadPost *
                \ if line("'\"") > 1 && line("'\"") <= line("$") |
                \   exe "normal! g`\"" |
                \ endif

augroup END


" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
    command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
                \ | wincmd p | diffthis
endif

" }}}
" Startify cows {{{
autocmd User Startified setlocal buftype=
let g:startify_list_order    = ['sessions', 'bookmarks', 'files']
let g:startify_bookmarks     = [
            \"~/Projects/blog/index.html"
            \]
let g:startify_custom_header = [
            \"                                       \\  |  /         ___________",
            \"                        ____________  \\ \\_# /         |  ___      |       _________",
            \"                       |            |  \\  #/          | |   |     |      | = = = = |",
            \"                       | |   |   |  |   \\\\#           | |`v'|     |      |         |",
            \"                       |            |    \\#  //       |  --- ___  |      | |  || | |",
            \"                       | |   |   |  |     #_//        |     |   | |      |         |",
            \"                       |            |  \\\\ #_/_______  |     |   | |      | |  || | |",
            \"                       | |   |   |  |   \\\\# /_____/ \\ |      ---  |      |         |",
            \"                       |            |    \\# |+ ++|  | |  |^^^^^^| |      | |  || | |",
            \"                       |            |    \\# |+ ++|  | |  |^^^^^^| |      | |  || | |",
            \"                    ^^^|    (^^^^^) |^^^^^#^| H  |_ |^|  | |||| | |^^^^^^|         |",
            \"                       |    ( ||| ) |     # ^^^^^^    |  | |||| | |      | ||||||| |",
            \"                       ^^^^^^^^^^^^^________/  /_____ |  | |||| | |      | ||||||| |",
            \"                            `v'-                      ^^^^^^^^^^^^^      | ||||||| |",
            \"                             || |`.      (__)    (__)                          ( )",
            \"                                         (oo)    (oo)                       /---V",
            \"                                  /-------\\/      \\/ --------\\             * |  |",
            \"                                 / |     ||        ||_______| \\",
            \"                                *  ||W---||        ||      ||  *",
            \"                                   ^^    ^^        ^^      ^^",
            \]
" }}}
" Plugins {{{
" Loading plugin manager
" And plugins
call plug#begin('~/.config/nvim/plugged')

Plug 'xolox/vim-misc'
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'powerman/vim-plugin-AnsiEsc'
"Autosave settings
Plug 'duff/vim-bufonly'

" Colors and icons {{{
"" Configuring theme
"Plug 'tomasr/molokai'
Plug 'morhetz/gruvbox'
Plug 'geoffharcourt/one-dark.vim'
"Plug 'jonathanfilip/vim-lucius'
"Plug 'Lokaltog/vim-distinguished'
"Plug 'nanotech/jellybeans.vim'
"Plug 'zeis/vim-kolor'
"Plug 'chriskempson/vim-tomorrow-theme'
"Plug 'shawncplus/skittles_berry'
"Plug 'daylerees/colour-schemes', { 'rtp': 'vim/' }
Plug 'ninja/sky'
Plug 'ryanoasis/vim-webdevicons'
Plug 'bling/vim-airline'
Plug 'jszakmeister/vim-togglecursor'
" }}}
" Autocompletion {{{
"Plug 'Shougo/neocomplete.vim'
Plug 'Valloric/YouCompleteMe', { 'do': './install.sh' }
"Plug 'Shougo/deoplete.nvim'
"Plug 'ervandew/supertab'
" }}}
" Project navigation {{{
Plug 'mhinz/vim-startify'
Plug 'LucHermitte/lh-vim-lib'
Plug 'LucHermitte/local_vimrc'
let g:local_vimrc='.vimrc'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'Shougo/unite.vim'
Plug 'rking/ag.vim'

Plug 'Shougo/neomru.vim'

Plug 'majutsushi/tagbar'
" }}}
" Syntax checker {{{
"Plug 'scrooloose/syntastic'
Plug 'benekastah/neomake'
" }}}
" Configuring tabulation and codestyle {{{
Plug 'tpope/vim-repeat' " repeating .
Plug 'paradigm/TextObjectify'
Plug 'Raimondi/delimitMate'
Plug 'Yggdroot/indentLine'

" Working with code
Plug 'tpope/vim-surround'       " It's all about surrounding(quotes, brackets and etc)
Plug 'matze/vim-move'           " Moving lines fast and easy
Plug 'scrooloose/nerdcommenter' " Commenting/uncommenting code
" }}}
" Api Blueprint {{{
Plug 'kylef/apiblueprint.vim'
" }}}
" Snippets {{{
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
" }}}
" Git {{{
Plug 'tpope/vim-fugitive'
Plug 'int3/vim-extradite'
Plug 'idanarye/vim-merginal'
Plug 'gregsexton/gitv'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/gv.vim'

Plug 'mattn/webapi-vim'
Plug 'mattn/gist-vim' " Github's gist
" }}}
" HTML5/CSS3/LESS {{{
Plug 'mattn/emmet-vim', {'for': ['html', 'xhtml', 'css', 'less']}

Plug 'rstacruz/sparkup'

Plug 'othree/html5-syntax.vim',   { 'for': ['html']   }
Plug 'Valloric/MatchTagAlways',   { 'for': ['html']   }
Plug 'groenewege/vim-less',       { 'for': ['less']   }
"Plug 'hail2u/vim-css3-syntax',    { 'for': ['html','css'] }
Plug 'wavded/vim-stylus'
"Plug 'skammer/vim-css-color'
Plug 'tpope/vim-markdown',   { 'for': ['markdown']   }
Plug 'suan/vim-instant-markdown'
Plug 'tpope/vim-haml'
" }}}
" javascript {{{
Plug 'marijnh/tern_for_vim', { 'for': 'javascript' }
Plug 'jussi-kalliokoski/harmony.vim', { 'for': 'javascript' }
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'jelera/vim-javascript-syntax', { 'for': 'javascript' }
Plug 'mxw/vim-jsx'
Plug 'moll/vim-node'
Plug 'claco/jasmine.vim',                           { 'for': 'javascript' }
Plug 'othree/javascript-libraries-syntax.vim',      { 'for': 'javascript' }
"Plug 'jason0x43/vim-js-indent'
" }}}
" TypeScript {{{
Plug 'leafgarland/typescript-vim'
Plug 'Quramy/tsuquyomi'
" }}}
" Gherkin {{{
"Plug 'tpope/vim-cucumber'
Plug 'veloce/vim-behat'
" }}}
" php {{{
Plug 'vim-php/vim-php-refactoring'
Plug 'mkusher/padawan.vim'

Plug 'tobyS/vmustache'
Plug 'tobyS/pdv'
" Debugger {{{
Plug 'joonty/vdebug'
let g:vdebug_options = {"port":9101} " Value from xdebug.ini: xdebug.remote_port
" }}}
" }}}
" Python plugins {{{
Plug 'klen/python-mode'
Plug 'davidhalter/jedi-vim'
" }}}
" Rust {{{
Plug 'rust-lang/rust.vim'
Plug 'timonv/vim-cargo'
Plug 'phildawes/racer', { 'do': 'cargo build --release' }
" }}}
" Haskell {{{
Plug 'eagletmt/neco-ghc' " Great autocomplete plugin
Plug 'eagletmt/ghcmod-vim' " Types, locations and other cool stuff
Plug 'raichoo/haskell-vim' " Syntax colors
" }}}
" Lua {{{
Plug 'xolox/vim-lua-ftplugin'
" }}}
" Yaml {{{
Plug 'stephpy/vim-yaml'
" }}}

call plug#end()
" }}}

" Autocompletion {{{
" Neocomplete {{{
 ""<TAB>: completion.
"inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
"let g:acp_enableAtStartup = 0
"" Use neocomplete.
"let g:neocomplete#enable_at_startup = 1
"" Use smartcase.
"let g:neocomplete#enable_smart_case = 1
"" Set minimum syntax keyword length.
"let g:neocomplete#sources#syntax#min_keyword_length = 3
"let g:neocomplete#enable_auto_delimiter = 1
"let g:neocomplete#use_vimproc = 1
"let g:neocomplete#force_omni_input_patterns = {}
" }}}

let g:ycm_autoclose_preview_window_after_completion = 1
"let g:ycm_complete_in_strings = 1
let g:ycm_complete_in_comments = 1
let g:ycm_key_list_select_completion = ['<Tab>', '<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:ycm_semantic_triggers =  {
            \   'c' : ['->', '.'],
            \   'objc' : ['->', '.'],
            \   'ocaml' : ['.', '#'],
            \   'cpp,objcpp' : ['->', '.', '::'],
            \   'perl' : ['->'],
            \   'cs,java,d,perl6,scala,vb,elixir,go' : ['.'],
            \   'rust' : ['.', '::'],
            \   'html': ['<', '"', '</', ' '],
            \   'vim' : ['re![_a-za-z]+[_\w]*\.'],
            \   'ruby' : ['.', '::'],
            \   'lua' : ['.', ':'],
            \   'erlang' : [':'],
            \   'haskell' : ['.', 're!.']
            \ }
let g:ycm_filetype_specific_completion_to_disable = {
            \ 'gitcommit': 1
            \}
" }}}
" GIT {{{
let g:gist_post_private = 1

" }}}
" Syntax linter {{{

" Syntastic {{{
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"let g:syntastic_auto_jump               = 0
"let g:syntastic_error_symbol            = '✖'
"let g:syntastic_warning_symbol          = '►'
"let g:syntastic_style_error_symbol      = '~'
"let g:syntastic_style_warning_symbol    = '⚠'

"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
" }}}
" Neomake {{{
let g:neomake_airline = 0
let g:neomake_open_list = 2
"autocmd! BufWritePre * Neomake
" }}}
" }}}
" Project Navigation {{{
call unite#custom#source('file_rec/neovim2', 'ignore_pattern', 'bower_components\|node_modules\|dist\|tmp\|public\|vendor')
" }}}

autocmd BufNewFile,BufReadPost *.md set filetype=markdown
" JS {{{
let g:use_emmet_complete_tag = 1
autocmd BufNewFile,BufReadPost *.es6 set filetype=javascript
let javascript_enable_domhtmlcss = 1
let g:html_indent_inctags        = "html,body,head,tbody"
let g:html_indent_script1        = "inc"
let g:html_indent_style1         = "inc"
"let g:syntastic_javascript_checkers = ['jshint', 'jscs']
let g:neomake_javascript_enabled_makers = ['eslint']
let g:ycm_semantic_triggers.javascript =
            \ ['.', 'from "', "from '"]
let g:tagbar_type_javascript = {
    \ 'ctagsbin' : 'jsctags'
\ }
autocmd BufNewFile,BufReadPost *.jade set filetype=haml
" }}}
" TypeScript {{{
autocmd BufNewFile,BufRead *.tsx setlocal filetype=typescript

let g:ycm_filetype_specific_completion_to_disable.typescript = 1
let g:syntastic_typescript_checkers = ['tsc', 'tslint']
let g:syntastic_typescript_tsc_args = '-t ES6'
let g:neomake_typescript_enabled_makers = ['tsc', 'tslint']
let g:neomake_typescript_tsc_maker = {
            \ 'args': [
            \ '-m', 'system', '--noEmit', '--jsx', 'preserve', '-t', 'ES6',
            \ '--moduleResolution', 'classic', '--isolatedModules',
            \ '--experimentalDecorators'
            \ ],
            \ 'errorformat':
            \ '%E%f %#(%l\,%c): error %m,' .
            \ '%E%f %#(%l\,%c): %m,' .
            \ '%Eerror %m,' .
            \ '%C%\s%\+%m'
            \ }
let g:tsuquyomi_disable_quickfix = 1
let g:tagbar_type_typescript = {
            \ 'ctagstype': 'typescript',
            \ 'kinds': [
            \ 'c:classes',
            \ 'n:modules',
            \ 'f:functions',
            \ 'v:variables',
            \ 'v:varlambdas',
            \ 'm:members',
            \ 'i:interfaces',
            \ 'e:enums',
            \ ]
            \ }
" }}}
" PHP {{{
"let g:syntastic_php_phpcs_args='--tab-width=0 --standard=PSR1,PSR2'
"let g:syntastic_php_checkers = ['php', 'phpcs']
let g:neomake_php_enabled_makers = ['php', 'phpcs']
let g:neomake_php_phpcs_maker = {
            \ 'args': ['--tab-width=0', '--standard=PSR1,PSR2']
            \ }
let g:padawan#composer_command = '/home/mkusher/.scripts/composer'
let g:padawan#timeout = "0.75"
let g:ycm_semantic_triggers.php =
            \ ['->', '::', '(', 'new ', 'use ', 'namespace ', '\', '$', ' ']
"let g:neocomplete#force_omni_input_patterns.php =
            "\ '\h\w*\|[^- \t]->\w*'
" }}}
" Python {{{
"let g:neocomplete#force_omni_input_patterns.python =
"\ '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'
"" alternative pattern: '\h\w*\|[^. \t]\.\w*'
let g:ycm_semantic_triggers.python = ['.', 'import ']
" }}}
" Haskel {{{
let g:necoghc_enable_detailed_browse = 1 " detailed description
let g:haskell_enable_quantification = 1 " to enable highlighting of forall
let g:haskell_enable_recursivedo = 1 " to enable highlighting of mdo and rec
let g:haskell_enable_arrowsyntax = 1 " to enable highlighting of proc
let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of pattern
let g:haskell_enable_typeroles = 1 " to enable highlighting of type roles
" }}}
" Rust {{{
let g:racer_cmd = "/home/mkusher/.vim/plugged/racer/target/release/racer"
let $RUST_SRC_PATH="/home/mkusher/public_html/rust/src/src/"
" }}}

" UI {{{
" Editor {{{
" allow backspacing over everything in insert mode
set backspace=indent,eol,start

"set nobackup		" do not keep a backup file, use versions instead
set backupcopy=yes
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
let &colorcolumn=join(range(80,999),",")
set cursorline
set scrolloff=5
set wildmenu
set laststatus=2
set noshowmode " Disabling default mode indicator
set foldmethod=syntax
"set foldlevel=1

" Lines numbers
" Shows ruler when leaving insert mode
set nu
set rnu
set nuw=4
autocmd InsertEnter * set nornu
autocmd InsertLeave * set rnu
autocmd BufEnter * set nornu

" Configuring splits
set splitright
set splitbelow
augroup PreviewOnBottom
    autocmd InsertEnter * set splitbelow
    autocmd InsertLeave * set splitbelow!
augroup END

let delimitMate_expand_space = 1
let delimitMate_expand_cr = 1
" Default tabulation options
" Should be override in ft-configs
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent		" always set autoindenting on
set smarttab
set smartindent
let g:indentLine_enabled    = 1
let g:indentLine_char       = '¦'
syntax enable
set fillchars=|
" }}}
" GUI {{{
set mouse=r
let g:hybrid_use_Xresources = 1
let g:webdevicons_enable_nerdtree = 1
let g:WebDevIconsUnicodeDecorateFolderNodes = 0
let g:WebDevIconsUnicodeGlyphDoubleWidth = 0

" Airline
let g:airline_theme='gruvbox'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0
" set the CN (column number) symbol:
let g:airline_section_z = airline#section#create(["\uE0A1" . '%{line(".")}' . "\uE0A3" . '%{col(".")}'])

set background=dark
colors gruvbox

if has("gui_running")
    highlight LineNr guibg=#3c3836
    highlight LineNr guifg=#a89984
    set guifont=Liberation\ Mono\ for\ Powerline\ 12

    set guioptions-=T  " no toolbar
    set guioptions-=m  " no menu
    set guioptions-=r  " no right scroll
    set guioptions-=L  " no left scroll
    winsize 140 45
    "winpos 10 35
elseif has("nvim")
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
" }}}
" }}}
" Shortcuts {{{

let mapleader=","

" {{{ Snippets
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
" }}}
" Clipboard {{{
if has('nvim')
    set clipboard+=unnamedplus
else
    set clipboard=unnamedplus
endif
" }}}
" ALT {{{
if !has('gui_running') && !has('nvim')
    "" fixing Alt key to work in konsole
    let c='a'
    while c <= 'z'
        exec "set <A-".c.">=\e".c
        exec "imap \e".c." <A-".c.">"
        let c = nr2char(1+char2nr(c))
    endw

    set timeout ttimeoutlen=0
endif
if has('neovim')
    set timeout ttimeoutlen=1
end
" }}}
" {{{ Autcompletion
inoremap <C-Space> <C-x><C-o>
inoremap <C-@> <C-x><C-o>
imap <buffer> <Nul> <C-Space>
smap <buffer> <Nul> <C-Space>
" }}}
" Relative number toggle {{{
function! NumberToggle()
    if(&relativenumber == 1)
        set relativenumber!
    else
        set relativenumber
    endif
endfunction

nnoremap <Leader>r :call NumberToggle()<cr>
" }}}
" ESC {{{
noremap  <F1> <Esc>
inoremap <F1> <Esc>
vnoremap <F1> <Esc>
map  <Leader>i <Esc>
nmap <Leader>i <Esc>
vmap <Leader>i <Esc>
imap <Leader>i <Esc>
map <A-i> <Esc>
nmap <A-i> <Esc>
vmap <A-i> <Esc>
imap <A-i> <Esc>
imap jk <Esc>
" }}}
" Git actions {{{
noremap <Leader>gs :Gstatus<CR>
noremap <Leader>gc :Gcommit<CR>
" }}}
" Buffers {{{
nnoremap <C-h> <C-W><C-H>
nnoremap <C-l> <C-W><C-L>
nnoremap <C-k> <C-W><C-K>
nnoremap <C-j> <C-W><C-J>
" Tabs {{{
nmap <Leader>. :tabnext<CR>
nmap <Leader>, :tabprevious<CR>
" }}}
" Splits {{{
nmap <Leader>h :sp<CR>
nnoremap <Leader>v :vsp<CR>
" }}}
" Exit {{{
nnoremap Q :wq<CR>
nnoremap <Leader>q :q<CR>
" }}}
" Root save {{{
cmap w!! w !sudo tee % >/dev/null
" }}}
" Pretty json {{{
cmap pjson %!python -m json.tool
" }}}
" }}}
" Project navigation {{{
noremap <C-n> :NERDTreeToggle<CR>
noremap <Leader>n :NERDTreeToggle<CR>
noremap <Leader>f :NERDTreeFind<CR>
noremap <Leader>u :Unite<CR>
"noremap <C-p> :Unite file_rec/async -start-insert<CR> CtrlP
noremap <Leader>p :Unite file_rec/neovim2 -start-insert<CR>
nnoremap <Leader>e :Unite neomru/file<CR>j
" }}}
" Goodbye arrows ;( {{{
noremap   <Up>     <NOP>
noremap   <Down>   <NOP>
noremap   <Left>   <NOP>
noremap   <Right>  <NOP>
imap      <Up>     <NOP>
imap      <Down>   <NOP>
imap      <up>     <NOP>
imap      <down>   <NOP>
inoremap  <Left>   <NOP>
inoremap  <Right>  <NOP>
" }}}
" }}}
" vim:foldmethod=marker:foldlevel=0
