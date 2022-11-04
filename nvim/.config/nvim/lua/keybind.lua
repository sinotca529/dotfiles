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

-- Alias of C-@
vim.api.nvim_set_keymap('n', '<C-Space>', '<C-@>', {silent=true})
vim.api.nvim_set_keymap('t', '<C-Space>', '<C-@>', {silent=true})
vim.api.nvim_set_keymap('i', '<C-Space>', '<C-@>', {silent=true})

