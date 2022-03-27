call plug#begin("~/.config/nvim/plug")

" style
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'

" navigation
Plug 'christoomey/vim-tmux-navigator'
Plug 'benmills/vimux'
Plug 'roxma/vim-tmux-clipboard'

Plug 'tpope/vim-surround'

" Telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/lsp-status.nvim'

" Completion
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

Plug 'rust-lang/rust.vim'

Plug 'jiangmiao/auto-pairs'

call plug#end()

function! RunCargoTests()
    let path = split(expand("%:p:h"), "/")
    while len(path) > 0 && path[-1] !=? "src"
        call remove(path, -1)
    endwhile
    if len(path) > 1
        let dir = join(path[0:-2], "/")
        call VimuxRunCommand("clear && cd /" . dir . " && cargo test")
    endif
endfunction

set shell=/bin/bash

set nocompatible
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
set backspace=indent,eol,start
set tabstop=4
set softtabstop=0
set shiftwidth=4
set expandtab
set so=999  " scrolloff, a large value will center the cursor in the file

set hidden

set nohlsearch
set incsearch
set ignorecase
set smartcase

set nobackup
set noswapfile
set undodir=~/.nvim/undodir
set undofile
set clipboard+=unnamedplus

set autoindent
set smartindent

set fileformats=unix,dos,mac

autocmd BufWritePre * %s/\s\+$//e
autocmd BufReadPost *.rs setlocal filetype=rust

nmap " " <Nop>
let mapleader=" "

cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall

let g:onedark_hide_endofbuffer = 1
let g:gruvbox_contrast_dark = 'soft'
colorscheme gruvbox

nnoremap \ :Explore<cr>
set rtp+=/usr/local/share/myc/vim

nnoremap <leader>w :bw<cr>
nnoremap <leader>n :bp<cr>
nnoremap <leader>e :bn<cr>
nnoremap <leader>v :VimuxRunLastCommand<cr>

nnoremap <leader>b :call RunCargoTests()<cr>
nnoremap <leader>r :lua vim.lsp.buf.rename()<cr>

nnoremap <c-s> :update<cr>
inoremap <c-s> <c-o>:update<cr>

nnoremap ; :

nnoremap <leader>f <cmd>Telescope find_files<cr>
nnoremap <leader>g <cmd>Telescope live_grep<cr>
nnoremap <leader>b <cmd>Telescope buffers<cr>
nnoremap <leader>h <cmd>Telescope help_tags<cr>

" Colemak
noremap e k
noremap E K
noremap k n
noremap K N
noremap n j
noremap N J
noremap j e
noremap J E

let g:tmux_navigator_no_mappings = 1
nnoremap <silent> C-n :TmuxNavigateLeft<cr>
nnoremap <silent> C-e :TmuxNavigateDown<cr>
" nnoremap <silent> :TmuxNavigateUp<cr>
" nnoremap <silent> :TmuxNavigateRight<cr>
nnoremap <silent> C-<Tab> :TmuxNavigatePrevious<cr>


" Disable inherited syntastic
let g:syntastic_mode_map = {
  \ "mode": "passive",
  \ "active_filetypes": [],
  \ "passive_filetypes": [] }

let g:neomake_serialize = 1
let g:neomake_serialize_abort_on_error = 1
let g:rustfmt_autosave = 1

let g:VimuxHeight = "35"
let g:VimuxOrientation = "h"

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'default'

set wildmode=list:longest,list:full
set wildignore+=*/node_modules/*,_site,*/__pycache__/,*/venv/*,*/target/*,*/.vim$,\~$,*/.log,*/.aux,*/.cls,*/.aux,*/.bbl,*/.blg,*/.fls,*/.fdb*/,*/.toc,*/.out,*/.glo,*/.log,*/.ist,*/.fdb_latexmk
" Tell FZF to use RG - so we can skip .gitignore files even if not using
" :GitFiles search
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden'

" LSP configuration

" LSP config, in lua
" lua require("lsp")

" Statusline
function! LspStatus() abort
  if luaeval('vim.lsp.buf_get_clients() > 0')
    return luaeval("require('lsp-status').status()")
  endif

  return ''
endfunction

" Diagnostic settings
let g:diagnostic_insert_delay = 1
let g:diagnostic_show_sign = 1
let g:diagnostic_enable_virtual_text = 1

" Set completeopt to have a better completion experience
set completeopt=menu,menuone,noselect
" set completeopt=menuone,noinsert,noselect
" Avoid showing message extra message when using completion
set shortmess+=c

" LUA !!
lua << EOS
require('telescope').setup {
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    }
  }
}

require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
  highlight = {
    enable = true,              -- false will disable the whole extension
    -- disable = { "rust" },
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}


-- Setup nvim-cmp.
local cmp = require'cmp'

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' }),
    ['<cr>'] = cmp.mapping.confirm({ select = true }),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
  }, {
    { name = 'buffer' },
  })
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- Setup lspconfig.
local lsp_status = require('lsp-status')
-- lsp_status.register_progress()

local capabilities = vim.lsp.protocol.make_client_capabilities()
require('cmp_nvim_lsp').update_capabilities(capabilities)
capabilities.window = capabilities.window or {}
capabilities.window.workDoneProgress = true

local nvim_lsp = require'lspconfig'

local set_keymap = function(key, mapping)
  vim.api.nvim_set_keymap("n", key, mapping, {noremap = true, silent = true})
end

local on_attach = function(client, bufnr)
  lsp_status.on_attach(client)

  -- Keybindings for LSPs
  -- Note these are in on_attach so that they don't override bindings in a non-LSP setting
  set_keymap("gd", "<cmd>lua vim.lsp.buf.definition()<cr>")
  set_keymap("gD", "<cmd>lua vim.lsp.buf.implementation()<cr>")
  set_keymap("1gD", "<cmd>lua vim.lsp.buf.type_definition()<cr>")
  set_keymap("gh", "<cmd>lua vim.lsp.buf.hover()<cr>")
  set_keymap("<c-k>", "<cmd>lua vim.lsp.buf.signature_help()<cr>")
  set_keymap("gr", "<cmd>lua vim.lsp.buf.references()<cr>")
  set_keymap("g0", "<cmd>lua vim.lsp.buf.document_symbol()<cr>")
  set_keymap("gW", "<cmd>lua vim.lsp.buf.workspace_symbol()<cr>")
  set_keymap("ga", "<cmd>lua vim.lsp.buf.code_action()<cr>")

  set_keymap("g[", "<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>")
  set_keymap("g]", "<cmd>lua vim.lsp.diagnostic.goto_next()<cr>")
  set_keymap("g/", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>")
end

nvim_lsp.rust_analyzer.setup({
    capabilities=capabilities,
    on_attach=on_attach,
    settings = {
        ["rust-analyzer"] = {
            assist = {
                importGranularity = "module",
                importPrefix = "by_self",
            },
            cargo = {
                loadOutDirsFromCheck = true
            },
            procMacro = {
                enable = true
            },
        }
    }
})

require'lspconfig'.jedi_language_server.setup{}
EOS
