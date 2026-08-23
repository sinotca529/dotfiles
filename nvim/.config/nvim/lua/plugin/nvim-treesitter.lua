return {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false,
    build = ':TSUpdate',
    config = function()
        require('nvim-treesitter').setup()
        require('nvim-treesitter').install({
            'c', 'cpp', 'llvm', 'rust',
            'lua', 'python',
            'markdown', 'markdown_inline',
            'latex',
        })

        -- main branch no longer auto-starts highlighting: https://neovim.io/doc/user/treesitter.html
        vim.api.nvim_create_autocmd('FileType', {
            pattern = { 'c', 'cpp', 'llvm', 'rust', 'lua', 'python', 'markdown', 'tex' },
            callback = function() pcall(vim.treesitter.start) end,
        })

        vim.wo.foldmethod = 'expr'
        vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    end
}
