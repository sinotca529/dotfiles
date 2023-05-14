local function swap_key(mode, key1, key2)
    vim.api.nvim_set_keymap(mode, key1, key2, {noremap=true})
    vim.api.nvim_set_keymap(mode, key2, key1, {noremap=true})
end

vim.api.nvim_set_keymap('i', 'jj', '<ESC>', {silent=true})

-- Swap j <-> gj, k <-> gk
swap_key('n', 'j', 'gj')
swap_key('n', 'k', 'gk')
swap_key('v', 'j', 'gj')
swap_key('v', 'k', 'gk')

-- Disable 'save & close'.
vim.api.nvim_set_keymap('n', 'ZZ', '<Nop>', {})
-- Disbale 'close without save'.
vim.api.nvim_set_keymap('n', 'ZQ', '<Nop>', {})
-- Do not yank when press x.
-- vim.api.nvim_set_keymap('n', 'x', '"_x', {})

-- Toggle word wrap
vim.api.nvim_set_keymap('n', '<M-z>', ':set wrap!<CR>', {silent=true})

-- Swap line
vim.api.nvim_set_keymap('n', '<C-j>', ':m .+1<CR>', {silent=true})
vim.api.nvim_set_keymap('n', '<C-k>', ':m .-2<CR>', {silent=true})

-- window
vim.api.nvim_set_keymap('n', 's', '<C-W>', {silent=true})
