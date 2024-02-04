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

Plug 'editorconfig/editorconfig-vim'
Plug 'Konfekt/FastFold'
Plug 'christoomey/vim-tmux-navigator'
Plug 'vim-scripts/groovy.vim'
"Plug 'github/copilot.vim'

Plug 'zbirenbaum/copilot.lua'

Plug 'puremourning/vimspector'

" Colors and icons {{{
"" Configuring theme
Plug 'ayu-theme/ayu-vim'

Plug 'https://github.com/ryanoasis/vim-devicons'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'https://github.com/adelarsq/vim-devicons-emoji'
Plug 'vim-airline/vim-airline'
" }}}
" Autocompletion {{{
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neovim/nvim-lspconfig'
Plug 'onsails/lspkind.nvim'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'ray-x/lsp_signature.nvim'
Plug 'zbirenbaum/copilot-cmp'
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
Plug 'pmizio/typescript-tools.nvim'
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

" Nvim LSP {{{
lua << EOF
  require("typescript-tools").setup {}
  require("copilot").setup({
    suggestion = { enabled = false },
    panel = { enabled = false },
  })
  require("copilot_cmp").setup()
  require "lsp_signature".setup {}
  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
      -- Enable completion triggered by <c-x><c-o>
      vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

      -- Buffer local mappings.
      -- See `:help vim.lsp.*` for documentation on any of the below functions
      local opts = { buffer = ev.buf }
      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
      vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
      vim.keymap.set({ 'n' }, '<Leader>t', function()       require('lsp_signature').toggle_float_win()
      end, { silent = true, noremap = true, desc = 'toggle signature' })
      vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, opts)
      vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename, opts)
      vim.keymap.set({ 'n', 'v' }, '<Leader>ca', vim.lsp.buf.code_action, opts)
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
      vim.keymap.set('n', '<Leader>f', function()
        vim.lsp.buf.format { async = true }
      end, opts)
    end,
  })

  local has_words_before = function()
      unpack = unpack or table.unpack
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end

  local lspkind = require('lspkind')
  local cmp = require'cmp'
  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            if #cmp.get_entries() == 1 then
              cmp.confirm({ select = true })
            else
              cmp.select_next_item()
            end
          --[[ Replace with your snippet engine (see above sections on this page)
          elseif snippy.can_expand_or_advance() then
            snippy.expand_or_advance() ]]
          elseif has_words_before() then
            cmp.complete()
            if #cmp.get_entries() == 1 then
              cmp.confirm({ select = true })
            end
          else
            fallback()
          end
        end, { "i", "s" }),
    }),
    formatting = {
        format = lspkind.cmp_format({
            mode = 'symbol_text', -- show only symbol annotations
            maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
            ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
            show_labelDetails = true,
            symbol_map = {
              Text = "󰉿",
              Method = "󰆧",
              Function = "󰊕",
              Constructor = "",
              Field = "󰜢",
              Variable = "󰀫",
              Class = "󰠱",
              Interface = "",
              Module = "",
              Property = "󰜢",
              Unit = "󰑭",
              Value = "󰎠",
              Enum = "",
              Keyword = "󰌋",
              Snippet = "",
              Color = "󰏘",
              File = "󰈙",
              Reference = "󰈇",
              Folder = "󰉋",
              EnumMember = "",
              Constant = "󰏿",
              Struct = "󰙅",
              Event = "",
              Operator = "󰆕",
              Copilot = ''
            }
        })
    },
    sources = cmp.config.sources({
      { name = "copilot", group_index = 2 },
      { name = 'nvim_lsp', group_index = 2 },
      { name = 'ultisnips' }, -- For ultisnips users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  lspkind.init()
EOF
" }}}

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
let g:vimspector_base_dir='/home/mkusher/.config/nvim/plugged/vimspector'

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
let g:indentLine_char       = '󰥭'
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
" Vimspector {{{
let g:vimspector_enable_mappings = 'HUMAN'
nmap <Leader>db <cmd>call vimspector#ToggleBreakpoint()<CR>
nmap <Leader>dc <cmd>call vimspector#Continue()<CR>
nmap <Leader>drc <cmd>call vimspector#RunToCursor()<CR>
nmap <Leader>dso <cmd>call vimspector#StepOver()<CR>
nmap <Leader>dsi <cmd>call vimspector#StepInto()<CR>
nmap <Leader>dsu <cmd>call vimspector#StepOut()<CR>
nmap <Leader>dq <cmd>VimspectorReset<CR>
" }}}
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
" }}}
" Project navigation {{{
noremap <Leader>p <cmd>Telescope find_files<CR>
nnoremap <Leader>e <cmd>Telescope oldfiles<CR>
nnoremap <Leader>d :e %:h<CR>
nnoremap <leader>ff <cmd>Telescope<cr>
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
" {{{ Code Actions
nnoremap <Leader>i <cmd>TSToolsAddMissingImports<CR>
" }}}
" }}}
" vim:foldmethod=marker:foldlevel=0
