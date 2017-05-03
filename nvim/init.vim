" Defaults {{{
" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
"set nocompatible
"set encoding=cp1251
set autoread
set hidden
set fileencodings=utf-8,cp1251,koi8-r,cp866
set wildignore+=node_modules/*
set wildignore+=bower_components/*
set wildignore+=typings/*
set wildignore+=app/cache/*
set wildignore+=vendor/*
set wildignore+=*.map

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

let g:auto_save = 0
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

" Hosts {{{
Plug 'neovim/node-host', { 'do': 'npm install' }
"call remote#host#Register('node', '*.js', function('host#Require'))
" }}}
Plug 'Shougo/vimproc.vim', { 'do': 'make' }

Plug 'xolox/vim-misc'
Plug 'powerman/vim-plugin-AnsiEsc'
Plug 'editorconfig/editorconfig-vim'
"Autosave settings
Plug 'duff/vim-bufonly'
Plug 'Konfekt/FastFold'
Plug 'christoomey/vim-tmux-navigator'

Plug 'ledger/vim-ledger' " Accounts & money

" Colors and icons {{{
"" Configuring theme
"Plug 'morhetz/gruvbox'
Plug 'mhartington/oceanic-next'

Plug 'ryanoasis/vim-webdevicons'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" }}}
" Autocompletion {{{
Plug 'Shougo/deoplete.nvim'
Plug 'ervandew/supertab'
" }}}
" Project navigation {{{
Plug 'mhinz/vim-startify'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'Shougo/denite.nvim'
Plug 'rking/ag.vim'
Plug 'Shougo/neomru.vim'
" }}}
" Syntax checker {{{
Plug 'sbdchd/neoformat'
Plug 'benekastah/neomake'
" }}}
" Configuring tabulation and codestyle {{{
Plug 'tpope/vim-repeat' " repeating .
Plug 'Raimondi/delimitMate'
Plug 'Yggdroot/indentLine'

" Working with code
Plug 'tpope/vim-surround'       " It's all about surrounding(quotes, brackets and etc)
Plug 'scrooloose/nerdcommenter' " Commenting/uncommenting code
" }}}
" Snippets {{{
Plug 'SirVer/ultisnips'
" }}}
" Git {{{
Plug 'tpope/vim-fugitive'
Plug 'int3/vim-extradite'
Plug 'airblade/vim-gitgutter'
Plug 'rhysd/committia.vim'

Plug 'mattn/webapi-vim'
Plug 'mattn/gist-vim' " Github's gist
" }}}
" Tex {{{
Plug 'lervag/vimtex'
" }}}
" HTML5/CSS3/LESS {{{
Plug 'othree/html5-syntax.vim',   { 'for': ['html']   }
Plug 'Valloric/MatchTagAlways',   { 'for': ['html']   }
Plug 'wavded/vim-stylus'
Plug 'tpope/vim-markdown',   { 'for': ['markdown']   }
Plug 'suan/vim-instant-markdown'
Plug 'tpope/vim-haml'
" }}}
" javascript {{{
Plug 'marijnh/tern_for_vim', { 'for': 'javascript' }
"Plug 'jussi-kalliokoski/harmony.vim', { 'for': 'javascript' }
"Plug 'pangloss/vim-javascript'
""Plug 'jelera/vim-javascript-syntax', { 'for': 'javascript' }
""Plug 'moll/vim-node'
""Plug 'claco/jasmine.vim',                           { 'for': 'javascript' }
"Plug 'othree/javascript-libraries-syntax.vim',      { 'for': 'javascript' }
"Plug 'jason0x43/vim-js-indent'
"Plug 'billyvg/tigris.nvim', { 'do': './install.sh' }
"Plug 'mxw/vim-jsx'
" }}}
" TypeScript {{{
Plug 'leafgarland/typescript-vim'
"Plug 'HerringtonDarkholme/yats.vim'
Plug 'Quramy/tsuquyomi'
Plug 'ianks/vim-tsx'
"Plug 'mhartington/deoplete-typescript'
" }}}
" Coverage {{{
Plug 'ruanyl/coverage.vim'
" }}}
" Gherkin {{{
"Plug 'tpope/vim-cucumber'
Plug 'veloce/vim-behat'
" }}}
" php {{{
Plug 'pbogut/deoplete-padawan'
" Debugger {{{
Plug 'joonty/vdebug'
let g:vdebug_options = {"port":9000} " Value from xdebug.ini: xdebug.remote_port
" }}}
" }}}
" Python plugins {{{
Plug 'davidhalter/jedi-vim'
" }}}
" Rust {{{
Plug 'rust-lang/rust.vim'
" }}}
" Haskell {{{
Plug 'eagletmt/neco-ghc' " Great autocomplete plugin
Plug 'eagletmt/ghcmod-vim' " Types, locations and other cool stuff
Plug 'neovimhaskell/haskell-vim'
" }}}
" Yaml {{{
Plug 'stephpy/vim-yaml'
" }}}

call plug#end()
" }}}

" Autocompletion {{{
let g:deoplete#enable_at_startup = 1
let g:deoplete#file#enable_buffer_path = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#omni_patterns = {}
let g:deoplete#sources = {}
" }}}
" GIT {{{
let g:gist_post_private = 1
let g:deoplete#sources.gitcommit=['github']
" }}}
" Syntax linter {{{
" Ale {{{
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'typescript': ['tslint', 'typecheck']
\}
let g:ale_sign_error = '✖'
let g:ale_sign_warning = '►'
let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ ok']
" }}}
" Syntastic {{{
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_auto_jump               = 0
let g:syntastic_error_symbol            = '✖'
let g:syntastic_warning_symbol          = '►'
let g:syntastic_style_error_symbol      = '~'
let g:syntastic_style_warning_symbol    = '⚠'

let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 0
" }}}
" Neomake {{{
"let g:neomake_open_list = 2
"autocmd! BufWritePost * Neomake
" }}}
" }}}
" Project Navigation {{{
""call unite#custom#source('file_rec/neovim2')
"let g:unite_source_file_rec_max_cache_files = -1
"let g:unite_source_rec_async_command =
            "\ ['ag', '--follow', '--nocolor', '--nogroup',
            "\  '--hidden', '-g', '']
"call unite#custom#source('file_rec,file_rec/async,file_rec/neovim',
            "\ 'max_candidates', 20)

" }}}

" JS {{{
autocmd BufNewFile,BufReadPost *.es6 set filetype=javascript
autocmd BufNewFile,BufReadPost .babelrc set filetype=json
autocmd BufNewFile,BufReadPost .eslintrc set filetype=json
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
autocmd BufNewFile,BufReadPost *.jade set filetype=haml

let g:coverage_json_report_path = "coverage/coverage-final.json"
let g:coverage_show_covered = 1
let g:coverage_auto_start = 0
let g:use_emmet_complete_tag = 1
let javascript_enable_domhtmlcss = 1
let g:html_indent_inctags        = "html,body,head,tbody"
let g:html_indent_script1        = "inc"
let g:html_indent_style1         = "inc"
"let g:syntastic_javascript_checkers = ['jshint', 'jscs']
let g:neomake_javascript_enabled_makers = ['eslint']
" }}}
" Python {{{
" }}}
" Haskel {{{

autocmd BufNewFile,BufReadPost xmobarrc set filetype=haskell
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
" Tex {{{
let g:tex_fast="r"
let g:tex_no_error=1
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
let &colorcolumn=80
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
let g:airline_theme='oceanicnext'
let g:airline_powerline_fonts = 1
let g:airline_mode_map = {
            \ '__' : '-',
            \ 'n'  : 'N',
            \ 'i'  : 'I',
            \ 'R'  : 'R',
            \ 'c'  : 'C',
            \ 'v'  : 'V',
            \ 'V'  : 'V',
            \ '' : 'V',
            \ 's'  : 'S',
            \ 'S'  : 'S',
            \ '' : 'S',
            \ }
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#fnamemod = '%:t'
"let g:airline_section_error = '%{ALEGetStatusLine()}'
let g:airline_section_z = airline#section#create(
            \ ["\uE0A1" . '%{line(".")}' . "\uE0A3" . '%{col(".")}']
            \)
" set the CN (column number) symbol:
"let g:airline_section_z = airline#section#create(["\uE0A1" . '%{line(".")}' . "\uE0A3" . '%{col(".")}'])
set background=dark
colors OceanicNext
hi clear SpellBad
hi SpellBad cterm=undercurl,bold guifg=#bb0000 gui=undercurl,bold

"highlight LineNr guibg=#3c3836
"highlight LineNr guifg=#a89984

if has("gui_running")
    set guifont=Literation\ Mono\ Powerline\ 18

    set guioptions-=T  " no toolbar
    set guioptions-=m  " no menu
    set guioptions-=r  " no right scroll
    set guioptions-=L  " no left scroll
    winsize 140 45
    "winpos 10 35
elseif has("nvim")
    set termguicolors
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
    let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
    " Use background of termite:
    highlight Normal guibg=none
endif
" }}}
" }}}
" Shortcuts {{{

let mapleader=","
let g:maplocalleader=","
nmap <Space> ,

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
" Syntax linter {{{
nmap <Leader>n :Neomake<CR>
nmap <Leader>f :Neoformat<CR>
" }}}
" {{{ Autcompletion
" C-Space is needed only when without YCM
inoremap <C-Space> <C-x><C-o>
inoremap <C-@> <C-x><C-o>
"inoremap <Tab> <C-n>
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
imap jk <Esc>
" }}}
" Git actions {{{
noremap <Leader>gs :Gstatus<CR>
noremap <Leader>gc :Gcommit<CR>
" }}}
" Buffers {{{
" Neovim hack
nmap <BS> :<c-u>TmuxNavigateLeft<CR>
" Now Using tmux navigation
"nnoremap <C-h> <C-W>h
"nnoremap <C-l> <C-W>l
"nnoremap <C-k> <C-W>k
"nnoremap <C-j> <C-W>j
" Tabs {{{
nmap <Leader>. :tabnext<CR>
nmap <Leader>, :tabprevious<CR>
" }}}
" Splits {{{
nmap <Leader>h :sp<CR>
nmap <Leader>- :sp<CR>
nmap <Leader>v :vsp<CR>
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
"noremap <C-n> :NERDTreeToggle<CR>
"noremap <Leader>n :NERDTreeToggle<CR>
"noremap <Leader>f :NERDTreeFind<CR>
noremap <Leader>u :Denite<CR>
"noremap <C-p> :Unite file_rec/async -start-insert<CR> CtrlP
noremap <Leader>p :Denite file_rec buffer<CR>
nnoremap <Leader>e :Denite file_mru<CR>
nnoremap <Leader>d :e %:h<CR>
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
