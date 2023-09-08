return {
    'williamboman/mason-lspconfig.nvim',
    lazy = true,
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
                on_attach = function(_, bufnr)
                    local bufopts = { silent = true, buffer = bufnr }
                    vim.keymap.set('n', '<space>', '<cmd>lua vim.lsp.buf.hover()<CR>', bufopts)
                    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', bufopts)
                    vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', bufopts)
                    vim.keymap.set('n', 'ge', '<cmd>lua vim.diagnostic.open_float()<CR>', bufopts)
                    -- vim.keymap.set('n', '<C-.>', '<cmd>lua vim.lsp.buf.code_action()<CR>', bufopts)
                    vim.keymap.set('n', '<C-n>', '<cmd>lua vim.lsp.buf.code_action()<CR>', bufopts)
                    vim.keymap.set('n', '<C-f>', '<cmd>lua vim.lsp.buf.format()<CR>', bufopts)
                    vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.rename()<CR>', bufopts)
                end,
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
