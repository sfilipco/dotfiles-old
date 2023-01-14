vim.opt.termguicolors = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv('HOME') .. '/.vim/undodir'
vim.opt.undofile = true

vim.opt.scrolloff = 999

vim.opt.colorcolumn = '80'

vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.api.nvim_create_autocmd('FileType', {
    pattern = 'xml',
    command = 'setlocal shiftwidth=2 tabstop=2'
})
