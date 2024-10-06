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

-- lsp
vim.api.nvim_create_augroup('lsp_keybind', {})
vim.api.nvim_create_autocmd('LspAttach', {
    group = 'lsp_keybind',
    once = true,
    callback = function()
        -- vim.keymap.set('n', '<space>', vim.lsp.buf.hover, { silent = true })
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { silent = true })
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { silent = true })
        -- vim.keymap.set('n', 'ge', vim.diagnostic.open_float, { silent = true })
        -- vim.keymap.set('n', '<C-.>', '<cmd>lua vim.lsp.buf.code_action()<CR>', { silent = true })
        -- vim.keymap.set('n', '<C-n>', vim.lsp.buf.code_action, { silent = true })
        vim.keymap.set('n', '<C-f>', vim.lsp.buf.format, { silent = true })
        vim.keymap.set('n', 'gr', vim.lsp.buf.rename, { silent = true })
    end
})
