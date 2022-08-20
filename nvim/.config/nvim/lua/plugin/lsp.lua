local use_arg_list = {
    --- lsp
    {'neovim/nvim-lspconfig'},
    {'williamboman/mason.nvim'},
    {'williamboman/mason-lspconfig.nvim'},
    --- complement
    {'hrsh7th/nvim-cmp'},
    {'hrsh7th/cmp-nvim-lsp'},
    -- show lsp state
    -- {'j-hui/fidget.nvim'},
}

local init = function()
    require('mason').setup({})
    local nvim_lsp = require('lspconfig')
    require('mason-lspconfig').setup_handlers({function(server_name)
        vim.o.signcolumn = 'yes'
        nvim_lsp[server_name].setup({
            on_attach = function(_, bufnr)
                local bufopts = {silent = true, buffer = bufnr}
                vim.keymap.set('n', '<space>', '<cmd>lua vim.lsp.buf.hover()<CR>', bufopts)
                vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', bufopts)
                vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', bufopts)
                vim.keymap.set('n', 'ge', '<cmd>lua vim.diagnostic.open_float()<CR>', bufopts)
                vim.keymap.set('n', '<C-.>', '<cmd>lua vim.lsp.buf.code_action()<CR>', bufopts)
            end,
            capabilities = require('cmp_nvim_lsp').update_capabilities(
                vim.lsp.protocol.make_client_capabilities()
            ),
            autostart = true,
            settings = {
                Lua = {
                    diagnostics = {
                        globals = {'vim'},
                    },
                },
            },
        })
    end})
    -- require('fidget').setup({})

    -- completion
    local cmp = require('cmp')
    cmp.setup({
        mapping = {
            ['<C-k>'] = cmp.mapping.select_prev_item(),
            ['<C-j>'] = cmp.mapping.select_next_item(),
            ['<CR>'] = cmp.mapping.confirm({select=true}),
            ['<C-q>'] = cmp.mapping.close(),
        },
        sources = {
            {name = 'nvim_lsp'},
            -- {name = 'buffer'},
        },
        -- experimental = {
        --     ghost_text = true,
        -- },
    })
    vim.diagnostic.config({virtual_text = false})
end

return {
    use_arg_list = use_arg_list,
    init = init,
}

