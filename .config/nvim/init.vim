" set runtimepath^=~/.vim runtimepath+=~/.vim/after
" let &packpath = &runtimepath

call plug#begin("~/.config/nvim/plug")

Plug 'neomake/neomake'
" Plug 'vim-syntastic/syntastic'
Plug 'rust-lang/rust.vim'
Plug '~/.extra/fzf'
Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
Plug 'joshdick/onedark.vim'
Plug 'morhetz/gruvbox'
Plug 'roxma/vim-tmux-clipboard'
Plug 'christoomey/vim-tmux-navigator'
Plug 'benmills/vimux'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
" Plug 'sirver/UltiSnips'

Plug 'neovim/nvim-lsp'
Plug 'nvim-lua/lsp-status.nvim'
Plug 'nathunsmitty/diagnostic-nvim'
 Plug 'nvim-lua/completion-nvim'

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
" Run NeoMake on read and write operations
autocmd! BufReadPost,BufWritePost * Neomake
" Use completion-nvim in every buffer
autocmd BufEnter * lua require'completion'.on_attach()

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

set termguicolors
let g:onedark_hide_endofbuffer = 1
let g:gruvbox_contrast_dark = 'soft'
colorscheme gruvbox

set rtp+=/usr/local/share/myc/vim

nnorema \ :Explore<CR>
nnoremap <Leader>t :FZF<CR>
nnoremap <leader>T :MYC<CR>
nnoremap <Leader>f :tjump<CR>
nnoremap <Leader>w :bw<CR>
nnoremap <Leader>j :bp<CR>
nnoremap <Leader>k :bn<CR>
nnoremap <Leader>l :bn<CR>
nnoremap <Leader>[ :bp<CR>
nnoremap <Leader>] :bn<CR>
nnoremap <Leader>v :VimuxRunLastCommand<CR>

nnoremap <Leader>b :call RunCargoTests()<CR>
nnoremap <Leader>, :cprev<CR>
nnoremap <Leader>. :cnext<CR>

nnoremap <C-S> :update<CR>
inoremap <C-S> <C-O>:update<CR>

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
lua require("lsp")

function! LspStatus() abort
  if luaeval('#vim.lsp.buf_get_clients() > 0')
    return luaeval("require('lsp-status').status()")
  endif
  return 'no-lsp-clients'
endfunction
set statusline+=\ %{LspStatus()}


" Diagnostic settings
let g:diagnostic_insert_delay = 1
let g:diagnostic_show_sign = 1
let g:diagnostic_enable_virtual_text = 1

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect
" Avoid showing message extra message when using completion
set shortmess+=c
