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
set wildignore+=vendor/*
set wildignore+=*.map

let mapleader=","
let g:maplocalleader=","
nmap <Space> ,

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
" Plugins {{{
" Loading plugin manager
" And plugins
call plug#begin('~/.config/nvim/plugged')


" Hosts {{{
Plug 'neovim/node-host', { 'do': 'npm install' }
" }}}
" Plugin Utils {{{
Plug 'nvim-lua/plenary.nvim'
" }}}

Plug 'powerman/vim-plugin-AnsiEsc'
Plug 'editorconfig/editorconfig-vim'
Plug 'Konfekt/FastFold'
Plug 'christoomey/vim-tmux-navigator'
Plug 'vim-scripts/groovy.vim'
"Plug 'github/copilot.vim'

Plug 'puremourning/vimspector'

" Colors and icons {{{
"" Configuring theme
Plug 'ayu-theme/ayu-vim'

Plug 'glepnir/galaxyline.nvim'
Plug 'https://github.com/ryanoasis/vim-devicons'
Plug 'https://github.com/adelarsq/vim-devicons-emoji'
" }}}
" Autocompletion {{{
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" }}}
" Project navigation {{{
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'Shougo/denite.nvim'
Plug 'Shougo/neomru.vim'
Plug 'mileszs/ack.vim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.4' }
Plug 'nvim-telescope/telescope-vimspector.nvim'

" }}}
" Syntax checker {{{

" }}}
" Configuring tabulation and codestyle {{{
Plug 'tpope/vim-repeat' " repeating .
Plug 'Raimondi/delimitMate'
Plug 'Yggdroot/indentLine'
Plug 'sbdchd/neoformat'

" Working with code
Plug 'tpope/vim-surround'       " It's all about surrounding(quotes, brackets and etc)
Plug 'scrooloose/nerdcommenter' " Commenting/uncommenting code
" }}}
" Snippets {{{
Plug 'SirVer/ultisnips'
" }}}
" Git {{{
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'airblade/vim-gitgutter'
Plug 'lambdalisue/gina.vim'

Plug 'mattn/webapi-vim'
Plug 'mattn/gist-vim' " Github's gist
" }}}
" Tex {{{
" }}}
" HTML5/CSS3/LESS {{{
Plug 'othree/html5-syntax.vim',   { 'for': ['html']   }
Plug 'Valloric/MatchTagAlways',   { 'for': ['html']   }
Plug 'wavded/vim-stylus'
Plug 'tpope/vim-markdown',   { 'for': ['markdown']   }
Plug 'tpope/vim-haml'
Plug 'hhsnopek/vim-sugarss'
" }}}
" javascript {{{
Plug 'pangloss/vim-javascript'
Plug 'flowtype/vim-flow'
Plug 'evanleck/vim-svelte', {'branch': 'main'}
" }}}
" TypeScript {{{
Plug 'HerringtonDarkholme/yats.vim'
Plug 'ianks/vim-tsx'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'yardnsm/vim-import-cost', { 'do': 'npm install' }
" }}}
" Ocaml\ReasonML {{{
Plug 'reasonml-editor/vim-reason-plus'
" }}}
" Coverage {{{
Plug 'ruanyl/coverage.vim'
" }}}
" Gherkin {{{
Plug 'veloce/vim-behat'
" }}}
" Python plugins {{{
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

Plug 'udalov/kotlin-vim'
call plug#end()
" }}}

" Autocompletion COC.nvim {{{
" use <tab> for trigger completion and navigate next complete item
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

nmap <silent> <Leader>t :call CocAction("doHover")<CR>
nmap <silent> <Leader>i :CocCommand tsserver.executeAutofix<CR>
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>rn <Plug>(coc-rename)

autocmd CursorHold * silent call CocActionAsync('highlight')
" }}}
" GIT {{{
let g:gist_post_private = 1
" }}}
" Syntax linter {{{
" Ale {{{
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'haskell': []
\}
let g:ale_sign_error = '✖'
let g:ale_sign_warning = '►'
let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ ok']
let g:airline#extensions#ale#enabled = 1
" }}}
" Syntastic {{{
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"let g:syntastic_auto_jump               = 0
"let g:syntastic_error_symbol            = '✖'
"let g:syntastic_warning_symbol          = '►'
"let g:syntastic_style_error_symbol      = '~'
"let g:syntastic_style_warning_symbol    = '⚠'

"let g:syntastic_check_on_open = 0
"let g:syntastic_check_on_wq = 0
"let g:syntastic_always_populate_loc_list = 0
"let g:syntastic_auto_loc_list = 0
" }}}
" Neomake {{{
"let g:neomake_open_list = 2
"autocmd! BufWritePost * Neomake
"call neomake#configure#automake('nrwi', 500)
"let g:neomake_eslint_maker = neomake#makers#ft#javascript#eslint()
"let g:neomake_eslint_maker.exe = 'npx'
"let g:neomake_eslint_maker.args = ['eslint'] + g:neomake_eslint_maker.args
" }}}
"

augroup fmt
  autocmd!
  "autocmd BufWritePre *.ts Neoformat
  "autocmd BufWritePre *.tsx Neoformat
  "autocmd BufWritePre *.js Neoformat
  "autocmd BufWritePre *.jsx Neoformat
augroup END
" }}}
" Project Navigation {{{
call denite#custom#var('file/rec', 'command',
	\ ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])
call denite#custom#source('grep', 'args', ['', '', '!'])
call denite#custom#kind('file', 'default_action', 'open')
autocmd FileType denite nnoremap <silent><buffer><expr> <CR>
\ denite#do_map('do_action')

let g:ackprg = 'ag --vimgrep'
let g:vimspector_base_dir='/Users/mkusher/.config/nvim/plugged/vimspector'

" }}}
augroup suffixes
  autocmd!

  let associations = [
              \["javascript", ".js,.jsx,.flow"]
              \]

  for ft in associations
      execute "autocmd FileType " . ft[0] . " setlocal suffixesadd=" . ft[1]
  endfor
augroup END
" JS {{{
autocmd BufNewFile,BufReadPost *.es6 set filetype=javascript
autocmd BufNewFile,BufReadPost .babelrc set filetype=json
autocmd BufNewFile,BufReadPost .eslintrc set filetype=json
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
autocmd BufNewFile,BufReadPost *.jade set filetype=haml
autocmd BufNewFile,BufReadPost Jenkinsfile set filetype=groovy

let g:svelte_preprocessors = ['typescript']
let g:coverage_json_report_path = "coverage/coverage-final.json"
let g:coverage_show_covered = 1
let g:coverage_auto_start = 0
let g:html_indent_inctags        = "html,body,head,tbody"
let g:html_indent_script1        = "inc"
let g:html_indent_style1         = "inc"
let g:user_emmet_settings = {
            \ 'typescript' : {
            \     'extends' : 'jsx',
            \ },
            \ 'typescript.tsx' : {
            \     'extends' : 'jsx',
            \ },
            \}
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
"let g:racer_cmd = "/home/mkusher/.vim/plugged/racer/target/release/racer"
let $RUST_SRC_PATH="/home/mkusher/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src"
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
autocmd TermOpen * setlocal nonumber norelativenumber

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
let g:indentLine_char       = '>'
syntax enable
set fillchars=|
" }}}
" GUI {{{

set mouse=r
let g:hybrid_use_Xresources = 1
let g:webdevicons_enable_nerdtree = 1
let g:WebDevIconsUnicodeDecorateFolderNodes = 0
let g:WebDevIconsUnicodeGlyphDoubleWidth = 0

let g:spaceline_seperate_style = 'curve'
" Airline
"let g:airline_theme='gruvbox'
"let g:airline_powerline_fonts = 1
"let g:airline_mode_map = {
"            \ '__' : '-',
"            \ 'n'  : 'N',
"            \ 'i'  : 'I',
"            \ 'R'  : 'R',
"            \ 'c'  : 'C',
"            \ 'v'  : 'V',
"            \ 'V'  : 'V',
"            \ '' : 'V',
"            \ 's'  : 'S',
"            \ 'S'  : 'S',
"            \ '' : 'S',
"            \ }
"let g:airline#extensions#tabline#enabled = 1
"let g:airline#extensions#tabline#show_buffers = 0
"let g:airline#extensions#tabline#show_buffers = 0
"let g:airline#extensions#tabline#fnamemod = '%:t'
"let g:airline_section_error = '%{ALEGetStatusLine()}'
"let g:airline_section_z = airline#section#create(
            "\ []
            "\)
"" set the CN (column number) symbol:
"let g:airline_section_z = airline#section#create(["\uE0A1" . '%{line(".")}' . "\uE0A3" . '%{col(".")}'])
"colors OceanicNext
"colors base16-default-dark
set background=dark
set termguicolors

let ayucolor="dark" " for mirage version of theme
colorscheme ayu

if has("gui_running")
    set guifont=Literation\ Mono\ Powerline\ 18

    set guioptions-=T  " no toolbar
    set guioptions-=m  " no menu
    set guioptions-=r  " no right scroll
    set guioptions-=L  " no left scroll
    winsize 140 45
    "winpos 10 35
endif
" }}}
" }}}
" Shortcuts {{{
let g:vimspector_enable_mappings = 'HUMAN'
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
if has('nvim')
  set timeout ttimeoutlen=1
end
" }}}
" Syntax check and format {{{
nmap <Leader>m :Neomake<CR>
nmap <Leader>f <Plug>(coc-format-selected)
xmap <Leader>f <Plug>(coc-format-selected)
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
imap jk <Esc>
tmap <Esc> <C-\><C-n>
tmap jk <C-\><C-n>
" }}}
" Git actions {{{
noremap <Leader>gs :Gina status<CR>
noremap <Leader>gc :Gina commit<CR>
" }}}
" Buffers {{{
" Neovim hack
"nmap <BS> :<c-u>TmuxNavigateLeft<CR>
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
noremap <Leader>p :Denite -split=floating -start-filter file/rec buffer<CR>
nnoremap <Leader>e :Denite -split=floating file_mru<CR>
nnoremap <Leader>d :e %:h<CR>
nnoremap <leader>j :AnyJump<CR>
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
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
