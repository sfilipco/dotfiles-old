vim.keymap.set('n', ';', ':')

vim.keymap.set('n', '\\', vim.cmd.Ex)
vim.keymap.set('n', '<leader>w', ':bw<cr>')
vim.keymap.set('n', '<leader>n', ':bp<cr>')
vim.keymap.set('n', '<leader>e', ':bn<cr>')

vim.keymap.set('n', '<c-s>', ':update<cr>')
vim.keymap.set('i', '<c-s>', '<c-o>:update<cr>')

-- Colemak
vim.keymap.set('n', 'e', 'k')
vim.keymap.set('n', 'E', 'K')
vim.keymap.set('n', 'k', 'n')
vim.keymap.set('n', 'K', 'N')
vim.keymap.set('n', 'n', 'j')
vim.keymap.set('n', 'N', 'J')
vim.keymap.set('n', 'j', 'e')
vim.keymap.set('n', 'J', 'E')
