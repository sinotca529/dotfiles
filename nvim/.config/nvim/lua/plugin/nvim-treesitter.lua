return {
    'nvim-treesitter/nvim-treesitter',
    -- event = { 'CursorHold', 'CursorHoldI' },
    config = function()
        require('nvim-treesitter.configs').setup({
            ensure_installed = {
                'c', 'cpp', 'llvm', 'rust',
                'lua', 'python',
                'markdown', 'markdown_inline',
                'latex',
            },
            auto_install = true,
            highlight = {
                enable = true,
                disable = { 'latex' },
            }
        })
        vim.wo.foldmethod = 'expr'
        vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
    end
}
