local function mason_lspconfig()
    return {
        'williamboman/mason-lspconfig.nvim',
        dependencies = {
            'neovim/nvim-lspconfig',
            'williamboman/mason.nvim',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/nvim-cmp'
        },
        config = function()
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
                        vim.keymap.set('n', '<C-S-f>', '<cmd>lua vim.lsp.buf.format()<CR>', bufopts)
                        vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.rename()<CR>', bufopts)
                    end,
                    capabilities = require('cmp_nvim_lsp').default_capabilities(),
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
        end
    }
end

local function nvim_cmp()
    return {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'dcampos/nvim-snippy',
            'dcampos/cmp-snippy' -- what is this?
        },
        config = function()
            local snippy = require('snippy')
            local cmp = require('cmp')
            local has_words_before = function()
                local line, col = table.unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, true)[1]:sub(col, col):match('%s') == nil
            end

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
            })
            vim.diagnostic.config({virtual_text = false})
        end
    }
end

local function fidget()
    return {
        'j-hui/fidget.nvim',
        config = function()
            require('fidget').setup({
                timer = {
                    task_decay = 0
                },
            })
        end
    }
end

return function(plugins)
    plugins[#plugins+1] = mason_lspconfig()
    plugins[#plugins+1] = nvim_cmp()
    plugins[#plugins+1] = fidget()
end
