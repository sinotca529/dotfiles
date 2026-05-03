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
        vim.wo.foldmethod = 'expr'
        vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    end
}
