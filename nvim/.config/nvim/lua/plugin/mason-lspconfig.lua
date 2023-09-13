return {
    'williamboman/mason-lspconfig.nvim',
    event = { 'BufReadPost', 'BufAdd', 'BufNewFile' },
    dependencies = {
        'neovim/nvim-lspconfig',
        'williamboman/mason.nvim',
        'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
        local nvim_lsp = require('lspconfig')
        require('mason-lspconfig').setup_handlers({ function(server_name)
            nvim_lsp[server_name].setup({
                capabilities = require('cmp_nvim_lsp').default_capabilities(),
                autostart = true,
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { 'vim' },
                        },
                    },
                },
            })
        end })
    end
}
