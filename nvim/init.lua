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
vmap <Space> ,

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
]])
-- }}}
-- Plugins {{{
local Plug = vim.fn['plug#']

vim.cmd('call plug#begin("~/.config/nvim/plugged")')

-- Hosts {{{
--Plug('neovim/node-host', { ['do'] = 'npm install' })
-- }}}
-- Plugin Utils {{{
Plug('nvim-lua/plenary.nvim')
Plug('MunifTanjim/nui.nvim')
Plug('grapp-dev/nui-components.nvim')

Plug('editorconfig/editorconfig-vim')
Plug('Konfekt/FastFold')
Plug('christoomey/vim-tmux-navigator')

Plug('MunifTanjim/nui.nvim')

Plug('powerman/vim-plugin-AnsiEsc')
Plug('nvim-treesitter/nvim-treesitter', {['do'] = ':TSUpdate'})

Plug('folke/snacks.nvim')
Plug('stevearc/dressing.nvim')
Plug('MunifTanjim/nui.nvim')
Plug('folke/trouble.nvim')
-- }}}

-- Colors and icons {{{
-- Configuring theme
Plug('savq/melange-nvim')

Plug('echasnovski/mini.nvim')

-- GPT/LLMs {{{
Plug('zbirenbaum/copilot.lua')
Plug('jackMort/ChatGPT.nvim')
Plug('olimorris/codecompanion.nvim')
Plug('yetone/avante.nvim', {['branch'] = 'main', ['do'] = 'make'})
-- }}}

-- Colors and icons {{{
--" Configuring theme
Plug('ellisonleao/gruvbox.nvim')
Plug('nvim-tree/nvim-web-devicons')
Plug('TaDaa/vimade')
-- }}}
-- }}}
-- Autocompletion {{{
Plug('neovim/nvim-lspconfig')
Plug('rafamadriz/friendly-snippets')
Plug('Saghen/blink.cmp', {['tag'] = 'v1.3.1'})
Plug('Saghen/blink.compat')
Plug('zbirenbaum/copilot-cmp')
-- }}}
-- Project navigation {{{
Plug('mileszs/ack.vim')
Plug('nvim-telescope/telescope.nvim', {['tag'] = '0.1.5' })
Plug('nvim-telescope/telescope-file-browser.nvim')
Plug('stevearc/oil.nvim')
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
--Plug('SirVer/ultisnips')
-- }}}
-- Git {{{
Plug('tpope/vim-fugitive')
Plug('tpope/vim-rhubarb')
Plug('airblade/vim-gitgutter')
Plug('lambdalisue/gina.vim')
-- }}}
-- DB {
Plug('tpope/vim-dadbod')
-- }
-- TypeScript {{{
Plug('yardnsm/vim-import-cost', { ['do'] = 'npm install' })
Plug('pmizio/typescript-tools.nvim')
-- }}}

vim.call('plug#end')
-- }}}

-- Nvim LSP {{{
require'lspconfig'.astro.setup{}
require'lspconfig'.hls.setup{}
require("copilot").setup({
  suggestion = { enabled = false },
  panel = { enabled = false },
})
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
require("lspconfig").protols.setup {}

local has_words_before = function()
  local col = vim.api.nvim_win_get_cursor(0)[2]
  if col == 0 then
    return false
  end
  local line = vim.api.nvim_get_current_line()
  return line:sub(col, col):match("%s") == nil
end

require('blink.cmp').setup({
    keymap = {
        preset = 'cmdline',
        ['<Tab>'] = {
            function(cmp)
              if has_words_before() then
                return cmp.insert_next()
              end
            end,
            'fallback',
        },
        ['<CR>'] = { 'accept', 'fallback' }
    },
    sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer', 'copilot' },
        providers = {
            copilot = {
                name = 'copilot',
                module = 'blink.compat.source',
                transform_items = function(ctx, items)
                  for _, item in ipairs(items) do
                    item.kind_icon = ''
                    item.kind_name = 'Copilot'
                  end
                  return items
                end
            }
        }
    },
    cmdline = {
      completion = {
          menu = {
              auto_show = true
          },
          list = {
              selection = {
                  preselect = false
              }
          }
      },
    },
    completion = {
        list = {
            selection = {
                preselect = false
            }
        },
        documentation = {
          auto_show = true
        }
    },
    signature = {
      enabled = true
    }
})


-- }}}

-- {{{ GPT/LLMs

require("avante").setup({
    provider = "copilot", -- "claude" or "openai" or "azure" or "deepseek" or "groq"
    providers = {
        openai = {
            endpoint = "https://api.openai.com",
            model = "gpt-4o"
        },
    }
})
require("codecompanion").setup()
-- }}}

-- Project Navigation {{{

vim.g.ackprg = 'ag --vimgrep'
vim.g.vimspector_base_dir='/home/mkusher/.config/nvim/plugged/vimspector'

require("telescope").setup {
  extensions = {
    file_browser = {
      theme = "ivy",
    }
  }
}
require("telescope").load_extension "file_browser"
require("oil").setup()
-- }}}
-- File types {{{
vim.cmd([[
autocmd BufNewFile,BufReadPost *.es6 set filetype=javascript
autocmd BufNewFile,BufReadPost .babelrc set filetype=json
autocmd BufNewFile,BufReadPost .eslintrc set filetype=json
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
autocmd BufNewFile,BufReadPost *.jade set filetype=haml
autocmd BufNewFile,BufReadPost Jenkinsfile set filetype=groovy
]])
-- }}}

-- UI {{{
-- Editor {{{
-- allow backspacing over everything in insert mode
vim.opt.backspace={'indent','eol','start'}

--set nobackup		" do not keep a backup file, use versions instead
vim.opt.backupcopy="yes"
vim.opt.history=50		-- keep 50 lines of command line history
vim.opt.ruler=true		-- show the cursor position all the time
vim.opt.showcmd=true	-- display incomplete commands
vim.opt.incsearch=true-- do incremental searching
vim.cmd("let &colorcolumn=80")
vim.opt.cursorline=true
vim.opt.scrolloff=5
vim.opt.wildmenu=true
vim.opt.laststatus=2
vim.opt.showmode=false -- Disabling default mode indicator
vim.opt.foldmethod="syntax"

-- Lines numbers
-- Shows ruler when leaving insert mode
vim.opt.nu=true
vim.opt.rnu=true
vim.opt.nuw=4

vim.cmd([[
autocmd InsertEnter * set nornu
autocmd InsertLeave * set rnu
autocmd BufEnter * set nornu
autocmd TermOpen * setlocal nonumber norelativenumber
]])

-- Configuring splits
vim.opt.splitright=true
vim.opt.splitbelow=true
vim.cmd([[
augroup PreviewOnBottom
    autocmd InsertEnter * set splitbelow
    autocmd InsertLeave * set splitbelow!
augroup END

let delimitMate_expand_space = 1
let delimitMate_expand_cr = 1
]])
-- Default tabulation options
-- Should be override in ft-configs
vim.opt.tabstop=4
vim.opt.shiftwidth=4
vim.opt.expandtab=true
vim.opt.autoindent=true
vim.opt.smarttab=true
vim.opt.smartindent=true
vim.g.indentLine_enabled    = 1
vim.g.indentLine_char       = '󰥭'
vim.cmd("syntax enable")
vim.cmd("set fillchars=|")
-- }}}
-- GUI {{{

vim.opt.mouse="r"
vim.opt.background="dark"
vim.opt.termguicolors=true

vim.cmd("colorscheme melange")

-- }}}
-- }}}
-- Shortcuts {{{
-- Vimspector {{{
vim.g.vimspector_enable_mappings = 'HUMAN'
vim.cmd([[
nmap <Leader>db <cmd>call vimspector#ToggleBreakpoint()<CR>
nmap <Leader>dc <cmd>call vimspector#Continue()<CR>
nmap <Leader>drc <cmd>call vimspector#RunToCursor()<CR>
nmap <Leader>dso <cmd>call vimspector#StepOver()<CR>
nmap <Leader>dsi <cmd>call vimspector#StepInto()<CR>
nmap <Leader>dsu <cmd>call vimspector#StepOut()<CR>
nmap <Leader>dq <cmd>VimspectorReset<CR>
]])
-- }}}
-- {{{ Snippets
vim.g.UltiSnipsExpandTrigger="<c-j>"
vim.g.UltiSnipsJumpForwardTrigger="<c-j>"
vim.g.UltiSnipsJumpBackwardTrigger="<c-k>"
-- }}}
-- Clipboard {{{
vim.cmd([[
  set clipboard+=unnamedplus
]])
-- }}}
-- ALT {{{
vim.cmd([[
  set timeout ttimeoutlen=1
]])
-- }}}
-- Relative number toggle {{{
vim.cmd([[
function! NumberToggle()
  if(&relativenumber == 1)
    set relativenumber!
  else
    set relativenumber
  endif
endfunction

nnoremap <Leader>r :call NumberToggle()<cr>
]])
-- }}}
-- ESC {{{
vim.cmd([[
noremap  <F1> <Esc>
inoremap <F1> <Esc>
vnoremap <F1> <Esc>
imap jk <Esc>
tmap <Esc> <C-\><C-n>
tmap jk <C-\><C-n>
]])
-- }}}
-- Git actions {{{
vim.cmd([[
noremap <Leader>gs :Gina status<CR>
noremap <Leader>gc :Git commit<CR>
" }}}
" Buffers {{{
" Tabs {{{
nmap <Leader>. :tabnext<CR>
nmap <Leader>, :tabprevious<CR>
]])
-- }}}
-- Splits {{{
vim.cmd([[
nmap <Leader>h :sp<CR>
nmap <Leader>- :sp<CR>
nmap <Leader>v :vsp<CR>
]])
-- }}}
-- Exit {{{
vim.cmd([[
nnoremap Q :wq<CR>
nnoremap <Leader>q :q<CR>
]])
-- }}}
-- Root save {{{
vim.cmd("cmap w!! w !sudo tee % >/dev/null")
-- }}}
-- }}}
-- Project navigation {{{
vim.cmd([[
noremap <Leader>p <cmd>Telescope find_files<CR>
nnoremap <Leader>e <cmd>Telescope oldfiles<CR>
nnoremap <Leader>d :e %:h<CR>
nnoremap <Leader>dr <cmd>Telescope file_browser<CR>
nnoremap <leader>ff <cmd>Telescope<cr>
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>lg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
]])
-- }}}
-- Goodbye arrows ;( {{{
vim.cmd([[
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
]])
-- }}}
-- {{{ Code Actions
vim.cmd("nnoremap <Leader>i <cmd>TSToolsAddMissingImports<CR>")
-- }}}

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
