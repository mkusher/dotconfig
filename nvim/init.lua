-- Defaults {{{

vim.opt.autoread=true
vim.opt.hidden=true
vim.opt.fileencodings={"utf-8","cp1251","koi8-r","cp866"}
vim.cmd([[
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
]])
-- }}}
-- Plugins {{{
local Plug = vim.fn["plug#"]
vim.cmd("call plug#begin('~/.config/nvim/plugged')")

-- Hosts {{{
Plug('neovim/node-host', { ['do'] = 'npm install' })
-- }}}
-- Plugin Utils {{{
Plug('nvim-lua/plenary.nvim')
Plug('MunifTanjim/nui.nvim')
-- }}}

Plug('powerman/vim-plugin-AnsiEsc')
Plug('editorconfig/editorconfig-vim')
Plug('Konfekt/FastFold')
Plug('christoomey/vim-tmux-navigator')

Plug('puremourning/vimspector')
Plug('nvim-treesitter/nvim-treesitter', {['do'] = ':TSUpdate'})

Plug('andythigpen/nvim-coverage')

Plug('MunifTanjim/nui.nvim')
Plug('folke/trouble.nvim')
Plug('jackMort/ChatGPT.nvim')


-- Colors and icons {{{
--" Configuring theme
Plug('ellisonleao/gruvbox.nvim')
-- }}}
-- Autocompletion {{{
Plug('neovim/nvim-lspconfig')
Plug('onsails/lspkind.nvim')
Plug('hrsh7th/cmp-nvim-lsp')
Plug('hrsh7th/cmp-buffer')
Plug('hrsh7th/cmp-path')
Plug('hrsh7th/cmp-cmdline')
Plug('hrsh7th/nvim-cmp')
-- }}}
-- Project navigation {{{
Plug('mileszs/ack.vim')
Plug('nvim-telescope/telescope.nvim', {['tag'] = '0.1.5' })
Plug('nvim-telescope/telescope-vimspector.nvim')
Plug('nvim-telescope/telescope-file-browser.nvim')
-- }}}
-- Configuring tabulation and codestyle {{{
Plug('tpope/vim-repeat')
Plug('Raimondi/delimitMate')
Plug('Yggdroot/indentLine')

-- Working with code
Plug('tpope/vim-surround')
Plug('scrooloose/nerdcommenter')
-- }}}
-- Snippets {{{
Plug('SirVer/ultisnips')
-- }}}
-- Git {{{
Plug('tpope/vim-fugitive')
Plug('tpope/vim-rhubarb')
Plug('airblade/vim-gitgutter')
Plug('lambdalisue/gina.vim')
-- }}}
-- TypeScript {{{
Plug('pmizio/typescript-tools.nvim')
-- }}}

vim.call("plug#end")
-- }}}

-- Nvim LSP {{{
require("typescript-tools").setup {
  settings = {
      tsserver_plugins = {
          "@styled/typescript-styled-plugin"
      }
  }
}
require("lspconfig").intelephense.setup {}
require("lspconfig").yamlls.setup {
  settings = {
      yaml = {
          schemas = {
              ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*",
              ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
              ["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
              ["http://json.schemastore.org/prettierrc"] = ".prettierrc.{yml,yaml}",
              ["http://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
              ["http://json.schemastore.org/ansible-playbook"] = "*play*.{yml,yaml}",
              ["http://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
              ["https://json.schemastore.org/dependabot-v2"] = ".github/dependabot.{yml,yaml}",
              ["https://json.schemastore.org/gitlab-ci"] = "*gitlab-ci*.{yml,yaml}",
              ["https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.1/schema.json"] = "*api*.{yml,yaml}",
              ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "*docker-compose*.{yml,yaml}",
              ["https://raw.githubusercontent.com/argoproj/argo-workflows/master/api/jsonschema/schema.json"] = "*flow*.{yml,yaml}",
              ["https://json.schemastore.org/package.json"] = "package.json",
              ["https://getcomposer.org/schema.json"] = "composer.json",
              ["https://json.schemastore.org/helmfile.json"] = "helmfile.{yml,yaml,json}",
              ["https://json.schemastore.org/tsconfig.json"] = "tsconfig.json",
          }
      }
  }
}

local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local lspkind = require('lspkind')
local cmp = require'cmp'
cmp.setup({
snippet = {
  expand = function(args)
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
    preset = 'default',
    maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
    ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)

    -- The function below will be called before any actual modifications from lspkind
    -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
    before = function (entry, vim_item)
      return vim_item
    end,
  })
},
sources = cmp.config.sources({
  { name = 'nvim_lsp' },
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
-- }}}

-- {{{ ChatGPT
vim.api.nvim_create_user_command("ChatGPTInit",
    function()
        require("chatgpt").setup({
            api_key_cmd = "op read op://private/OpenAI/api_key --no-newline"
        })
    end,
    {}
)
-- }}}

-- Project Navigation {{{

vim.g.ackprg = 'ag --vimgrep'
vim.g.vimspector_base_dir='/Users/mkusher/.config/nvim/plugged/vimspector'

require("telescope").setup {
extensions = {
  file_browser = {
    theme = "ivy",
    hijack_netrw = true
  }
}
}
require("telescope").load_extension "file_browser"

-- }}}

-- UI {{{
-- Editor {{{
vim.cmd([[
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
]])

require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false
  }
}
-- }}}
-- GUI {{{

vim.opt.mouse="r"
vim.opt.background="dark"
vim.opt.termguicolors=true
vim.cmd("colors gruvbox")

-- }}}
-- }}}
-- Shortcuts {{{
vim.cmd([[
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
set clipboard+=unnamedplus
" }}}
" ALT {{{
set timeout ttimeoutlen=1
" }}}
" {{{ Autcompletion
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
nnoremap <Leader>dr <cmd>Telescope file_browser<CR>
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
]])

-- Nvim LSP {{{
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
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
  vim.keymap.set('n', '<Leader>t', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', '<Leader>s', vim.lsp.buf.signature_help, opts)
  vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, opts)
  vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename, opts)
  vim.keymap.set({ 'n', 'v' }, '<Leader>ca', vim.lsp.buf.code_action, opts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
  vim.keymap.set('n', '<Leader>f', function()
    vim.lsp.buf.format { async = true }
  end, opts)
end,
})
-- }}}
-- }}}
-- vim:foldmethod=marker:foldlevel=0
