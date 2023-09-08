return {
    'jay-babu/mason-nvim-dap.nvim',
    dependencies = {
        'mfussenegger/nvim-dap',
        'williamboman/mason.nvim',
        'mfussenegger/nvim-dap'
    },
    config = function()
        require('mason-nvim-dap').setup({
            ensure_installed = { 'cppdbg' },
            handlers = {
                function(conf)
                    require('mason-nvim-dap').default_setup(conf)
                end,
            },
        })
    end
}
