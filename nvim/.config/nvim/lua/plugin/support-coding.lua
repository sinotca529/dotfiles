local mason = {
    'williamboman/mason.nvim',
    lazy = true,
    event = { 'BufReadPost', 'BufAdd', 'BufNewFile' },
    config = function()
        require('mason').setup({})
    end,
}

local mason_lspconfig = {
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
                    -- vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.rename()<CR>', bufopts)
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

local nvim_cmp = {
    'hrsh7th/nvim-cmp',
    lazy = true,
    event = 'InsertEnter',
    dependencies = {
        'dcampos/nvim-snippy',
        'dcampos/cmp-snippy',
        'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
        local snippy = require('snippy')
        snippy.setup({})
        local cmp = require('cmp')
        local has_words_before = function()
            local line, col = table.unpack(vim.api.nvim_win_get_cursor(0))
            return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
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
                end, { 'i', 's' }),
                ['<C-j>'] = cmp.mapping(function(fallback)
                    print(snippy.can_expand_or_advance())
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif snippy.can_expand_or_advance() then
                        snippy.expand_or_advance()
                    elseif has_words_before() then
                        cmp.complete()
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
                ['<CR>'] = cmp.mapping.confirm({ select = true }),
                ['<C-q>'] = cmp.mapping.close(),
            },
            sources = cmp.config.sources({
                { name = 'snippy' },
                { name = 'nvim_lsp' },
                { name = 'buffer' },
            }),
        })
        vim.diagnostic.config({ virtual_text = false })
    end
}

local null_ls = {
    "jose-elias-alvarez/null-ls.nvim",
    lazy = true,
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
        require('null-ls').setup()
    end
}

local mason_null_ls = {
    'jay-babu/mason-null-ls.nvim',
    lazy = true,
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
        "williamboman/mason.nvim",
        "jose-elias-alvarez/null-ls.nvim",
    },
    config = function()
        require('mason-null-ls').setup({
            automatic_setup = true,
            handlers = {},
        })
    end
}

local fidget = {
    'j-hui/fidget.nvim',
    tag = 'legacy',
    lazy = true,
    event = { 'LspAttach' },
    config = function()
        require('fidget').setup({
            timer = {
                task_decay = 0
            },
        })
    end
}

local guess_indent = {
    'NMAC427/guess-indent.nvim',
    lazy = true,
    event = { 'BufReadPost', 'BufAdd', 'BufNewFile' },
    config = function()
        require('guess-indent').setup({
            override_editorconfig = true,
        })
    end
}

local comment = {
    'numToStr/Comment.nvim',
    lazy = true,
    event = { 'BufReadPost', 'BufAdd', 'BufNewFile' },
    config = function()
        require('Comment').setup({
            line_mapping = '<leader>cc',
            toggler = {
                line = '<leader>cl',
            },
            opleader = {
                line = '<leader>cl',
            },
        })
    end
}

local nvim_tree = {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
        'nvim-tree/nvim-web-devicons',
    },
    config = function()
        local api = require('nvim-tree.api')
        vim.keymap.set('n', '<Leader>tt', api.tree.toggle, {})
        vim.keymap.set('n', '<Leader>tf', api.tree.focus, {})

        require('nvim-tree').setup({
            sort = {
                sorter = '',
            },
            filters = {
                git_ignored = false,
            },
            on_attach = function(bufnr)
                local api = require('nvim-tree.api')
                local function opts(desc)
                    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
                end

                vim.keymap.set('n', '<CR>', api.node.open.edit, opts('edit'))
                vim.keymap.set('n', 'p', api.fs.paste, opts('paste'))
                vim.keymap.set('n', 'x', api.fs.cut, opts('cut'))
                vim.keymap.set('n', 'd', api.fs.remove, opts('remove'))
                vim.keymap.set('n', 'a', api.fs.create, opts('create'))
                vim.keymap.set('n', '<C-r>', api.fs.rename, opts('rename'))
            end
        })
    end
}

local lsp_saga = {
    'nvimdev/lspsaga.nvim',
    dependencies = {
        'nvim-tree/nvim-web-devicons',
        'nvim-treesitter/nvim-treesitter',
    },
    lazy = true,
    event = 'LspAttach',
    config = function()
        local lspsaga = require('lspsaga')
        lspsaga.setup({
            symbol_in_winbar = { enable = false, },
            ui = {
                title = false,
                border = 'none',
                code_action = '',
            },
            beacon = {
                enable = false,
            },
            scrolling = {
                scroll_down = '<C-j>',
                scroll_up = '<C-k>',
            },
            implement = {
                enable = false,
            },
            finder = {
                default = 'typd+def+imp+ref',
                keys = {
                    toggle_or_open = '<CR>',
                },
            },
        })

        -- vim.keymap.set('n', '<space>', '<cmd>Lspsaga hover_doc<CR>')
        vim.keymap.set('n', '<C-.>', '<cmd>Lspsaga code_action<CR>')
        vim.keymap.set('n', 'gr', '<cmd>Lspsaga rename<CR>')
    end,
}

local lsp_signiture = {
    'ray-x/lsp_signature.nvim',
    lazy = true,
    event = 'LspAttach',
    config = function()
        require('lsp_signature').on_attach()
    end,
}

local surround = {
    'kylechui/nvim-surround',
    event = 'VeryLazy',
    config = function()
        require('nvim-surround').setup({})
    end
}

return function(plugins)
    plugins[#plugins + 1] = mason
    plugins[#plugins + 1] = mason_lspconfig
    plugins[#plugins + 1] = null_ls
    plugins[#plugins + 1] = mason_null_ls
    plugins[#plugins + 1] = nvim_cmp
    plugins[#plugins + 1] = fidget
    plugins[#plugins + 1] = guess_indent
    plugins[#plugins + 1] = comment
    plugins[#plugins + 1] = lsp_saga
    plugins[#plugins + 1] = lsp_signiture
    plugins[#plugins + 1] = surround
    plugins[#plugins + 1] = nvim_tree
end
