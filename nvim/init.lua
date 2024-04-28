-- Defaults {{{
vim.cmd([[
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
]])
-- }}}
-- Plugins {{{
local Plug = vim.fn['plug#']

vim.cmd('call plug#begin("~/.config/nvim/plugged")')

-- Hosts {{{
Plug('neovim/node-host', { ['do'] = 'npm install' })
-- }}}
-- Plugin Utils {{{
Plug('nvim-lua/plenary.nvim')
-- }}}

Plug('editorconfig/editorconfig-vim')
Plug('Konfekt/FastFold')
Plug('christoomey/vim-tmux-navigator')
Plug('vim-scripts/groovy.vim')

Plug('zbirenbaum/copilot.lua')

Plug('puremourning/vimspector')
Plug('nvim-treesitter/nvim-treesitter', {['do'] = ':TSUpdate'})

Plug('andythigpen/nvim-coverage')

Plug('MunifTanjim/nui.nvim')
Plug('folke/trouble.nvim')
Plug('jackMort/ChatGPT.nvim')

-- Colors and icons {{{
-- Configuring theme
Plug('savq/melange-nvim')
-- }}}
-- Autocompletion {{{
Plug('neovim/nvim-lspconfig')
Plug('onsails/lspkind.nvim')
Plug('hrsh7th/cmp-nvim-lsp')
Plug('hrsh7th/cmp-buffer')
Plug('hrsh7th/cmp-path')
Plug('hrsh7th/cmp-cmdline')
Plug('hrsh7th/nvim-cmp')
Plug('ray-x/lsp_signature.nvim')
--Plug('zbirenbaum/copilot-cmp')
-- }}}
-- Project navigation {{{
Plug('mileszs/ack.vim')
Plug('nvim-telescope/telescope.nvim', { ['tag'] = '0.1.4' })
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
Plug('airblade/vim-gitgutter')
Plug('lambdalisue/gina.vim')
-- }}}
-- TypeScript {{{
Plug('yardnsm/vim-import-cost', { ['do'] = 'npm install' })
Plug('pmizio/typescript-tools.nvim')
-- }}}

vim.call('plug#end')
-- }}}

-- Nvim LSP {{{
require("typescript-tools").setup {}
require("copilot").setup({
  suggestion = { enabled = false },
  panel = { enabled = false },
})
--require("copilot_cmp").setup()

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
            }
        }
    }
}

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
    vim.keymap.set('n', '<Leader>k', vim.lsp.buf.signature_help, opts)
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
-- }}}

-- Treesitter {

require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true,
  }
}

function styledHighlight()
  local M = {}

  local tbl = {}

  function tbl.contains(_tbl, value)
    for _, current in pairs(_tbl) do
      if current == value then
        return true
      end
    end

    return false
  end

  function M.directives()
    local function is_one_line(range)
      return range[1] == range[3]
    end

    local function is_range_empty_or_invalid(range)
      if range[3] < range[1] or (is_one_line(range) and range[4] <= range[2]) then
        return true
      end

      return false
    end

    local function make_subranges_between_children_like(node, predicate)
      local content = { { node:range() } }

      for child in node:iter_children() do
        if predicate(child) then
          local child_range = { child:range() }
          local last_content_range = content[#content]
          local first_part = {
            last_content_range[1],
            last_content_range[2],
            child_range[1],
            child_range[2],
          }
          local second_part = {
            child_range[3],
            child_range[4],
            last_content_range[3],
            last_content_range[4],
          }
          if is_range_empty_or_invalid(first_part) then
            if not is_range_empty_or_invalid(second_part) then
              content[#content] = second_part
            end
          elseif is_range_empty_or_invalid(second_part) then
            content[#content] = first_part
          else
            content[#content] = first_part
            content[#content + 1] = second_part
          end
        end
      end

      return content
    end

    local directives = vim.treesitter.query.list_directives()
    if not tbl.contains(directives, "inject_without_named_children!") then
      vim.treesitter.query.add_directive(
        "inject_without_named_children!",
        function(
          match,
          _, --[[ pattern ]]
          _, --[[ bufnr ]]
          predicate,
          metadata
        )
          local node = match[predicate[2]]
          metadata.content = make_subranges_between_children_like(
            node,
            function(child)
              return child:named()
            end
          )
        end
      )
    end

    if not tbl.contains(directives, "inject_without_children!") then
      vim.treesitter.query.add_directive("inject_without_children!", function(
        match,
        _, --[[ pattern ]]
        _, --[[ bufnr ]]
        predicate,
        metadata
      )
        local node = match[predicate[2]]
        metadata.content = make_subranges_between_children_like(node, function(_)
          return true
        end)
      end)
    end
  end

M.ecma_injections = [[
(comment) @jsdoc
(comment) @comment
(regex_pattern) @regex

; =============================================================================
; languages

; {lang}`<{lang}>`
(call_expression
function: ((identifier) @language)
arguments: ((template_string) @content
  (#offset! @content 0 1 0 -1)
  (#inject_without_children! @content)))

; gql`<graphql>`
(call_expression
function: ((identifier) @_name
  (#eq? @_name "gql"))
arguments: ((template_string) @graphql
  (#offset! @graphql 0 1 0 -1)
  (#inject_without_children! @graphql)))

; hbs`<glimmer>`
(call_expression
function: ((identifier) @_name
  (#eq? @_name "hbs"))
arguments: ((template_string) @glimmer
  (#offset! @glimmer 0 1 0 -1)
  (#inject_without_children! @glimmer)))

; =============================================================================
; styled-components

; styled.div`<css>`
(call_expression
function: (member_expression
  object: (identifier) @_name
    (#eq? @_name "styled"))
arguments: ((template_string) @css
  (#offset! @css 0 1 0 -1)
  (#inject_without_children! @css)))

; styled(Component)`<css>`
(call_expression
function: (call_expression
  function: (identifier) @_name
    (#eq? @_name "styled"))
arguments: ((template_string) @css
  (#offset! @css 0 1 0 -1)
  (#inject_without_children! @css)))

; styled.div.attrs({ prop: "foo" })`<css>`
(call_expression
function: (call_expression
  function: (member_expression
    object: (member_expression
      object: (identifier) @_name
        (#eq? @_name "styled"))))
arguments: ((template_string) @css
  (#offset! @css 0 1 0 -1)
  (#inject_without_children! @css)))

; styled(Component).attrs({ prop: "foo" })`<css>`
(call_expression
function: (call_expression
  function: (member_expression
    object: (call_expression
      function: (identifier) @_name
        (#eq? @_name "styled"))))
arguments: ((template_string) @css
  (#offset! @css 0 1 0 -1)
  (#inject_without_children! @css)))

; createGlobalStyle`<css>`
(call_expression
function: (identifier) @_name
  (#eq? @_name "createGlobalStyle")
arguments: ((template_string) @css
  (#offset! @css 0 1 0 -1)
  (#inject_without_children! @css)))
]]

  function M.queries()
    vim.treesitter.query.set("javascript", "injections", M.ecma_injections)
    vim.treesitter.query.set("typescript", "injections", M.ecma_injections)
    vim.treesitter.query.set("tsx", "injections", M.ecma_injections)
  end

  M.directives()
  M.queries()
end

styledHighlight()
-- }

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
vim.g.vimspector_base_dir='/home/mkusher/.config/nvim/plugged/vimspector'

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
-- JS {{{
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
noremap <Leader>gc :Gina commit<CR>
]])
-- }}}
-- Buffers {{{
-- Tabs {{{
vim.cmd([[
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
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
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
-- }}}
-- vim:foldmethod=marker:foldlevel=0
