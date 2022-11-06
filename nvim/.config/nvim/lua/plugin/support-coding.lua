return function(use)
    -- lsp
    use({'neovim/nvim-lspconfig'})
    use({'williamboman/mason.nvim'})
    use({'williamboman/mason-lspconfig.nvim'})
    -- complement
    use({'hrsh7th/nvim-cmp'})
    use({'hrsh7th/cmp-nvim-lsp'})
    -- snippet
    use({'dcampos/nvim-snippy'})
    use({'dcampos/cmp-snippy'})
    -- show lsp state
    use({'j-hui/fidget.nvim'})

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
                vim.keymap.set('n', '<C-S-f>', '<cmd>lua vim.lsp.buf.formatting()<CR>', bufopts)
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
    require('fidget').setup({
        timer = {
            task_decay = 0
        },
    })

    local snippy = require('snippy')

    local has_words_before = function()
        local line, col = table.unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, true)[1]:sub(col, col):match('%s') == nil
    end

    -- completion
    local cmp = require('cmp')
    cmp.setup({
        snippet = {
            expand = function(args)
                snippy.expand_snippet(args.body)
            end
        },
        mapping = {
            ['<C-k>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                elseif snippy.can_jump(-1) then
                    snippy.previous()
                else
                    fallback()
                end
            end, {'i', 's'}),
            ['<C-j>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                elseif snippy.can_expand_or_advance() then
                    snippy.expand_or_advance()
                elseif has_words_before() then
                    cmp.complete()
                else
                    fallback()
                end
            end, {'i', 's'}),
            ['<CR>'] = cmp.mapping.confirm({select=true}),
            ['<C-q>'] = cmp.mapping.close(),
        },
        sources = {
            {name = 'nvim_lsp'},
            {name = 'buffer'},
        },
        -- experimental = {
        --     ghost_text = true,
        -- },
    })
    vim.diagnostic.config({virtual_text = false})
end
