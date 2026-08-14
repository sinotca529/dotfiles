local function swap_key(mode, key1, key2)
    vim.keymap.set(mode, key1, key2, { noremap = true })
    vim.keymap.set(mode, key2, key1, { noremap = true })
end

vim.keymap.set('i', 'jj', '<ESC>', { silent = true })

-- Swap (j, gj), (k, gk)
swap_key('n', 'j', 'gj')
swap_key('n', 'k', 'gk')
swap_key('v', 'j', 'gj')
swap_key('v', 'k', 'gk')

vim.keymap.set('n', 'ZZ', '<Nop>', {})
vim.keymap.set('n', 'ZQ', '<Nop>', {})
vim.keymap.set('n', '<C-q>', '<Nop>', {})
vim.keymap.set('n', 'Y', 'y$', {})

-- Toggle word wrap
vim.keymap.set('n', '<M-z>', ':set wrap!<CR>', { silent = true })

-- Swap line
vim.keymap.set('n', '<C-j>', ':m .+1<CR>', { silent = true })
vim.keymap.set('n', '<C-k>', ':m .-2<CR>', { silent = true })
vim.keymap.set('v', '<C-j>', ":m '>+1<CR>gv-gv", { silent = true })
vim.keymap.set('v', '<C-k>', ":m '<-2<CR>gv-gv", { silent = true })

-- i<space>
vim.keymap.set('o', 'i<space>', 'iW', { silent = true })
vim.keymap.set('x', 'i<space>', 'iW', { silent = true })

-- window
vim.keymap.set('n', 's', '<C-W>', { silent = true })
