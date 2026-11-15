return {
    'jay-babu/mason-nvim-dap.nvim',
    lazy = true, -- loaded as a dependency of nvim-dap-ui (plugin/dap.lua)
    dependencies = {
        'mfussenegger/nvim-dap',
        'mason-org/mason.nvim',
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
