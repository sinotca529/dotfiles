local telescope = {
    'nvim-telescope/telescope.nvim',
    lazy = true,
    cmd = 'Telescope',
    version = '0.1.0',
    dependencies = { 'nvim-lua/plenary.nvim' },
    init = function()
        vim.keymap.set('n', '<leader>ff', '<Cmd>Telescope find_files<CR>', {})
        vim.keymap.set('n', '<leader>fg', '<Cmd>Telescope live_grep<CR>', {})
        vim.keymap.set('n', '<leader>fb', '<Cmd>Telescope buffers<CR>', {})
        vim.keymap.set('n', '<leader>fh', '<Cmd>Telescope help_tags<CR>', {})
    end,
    config = function()
        local ac = require('telescope.actions')
        require('telescope').setup({
            defaults = {
                mappings = {
                    i = {
                        ['<C-k>'] = ac.move_selection_previous,
                        ['<C-j>'] = ac.move_selection_next,
                    },
                },
            },
            file_ignore_patterns = {
                '*.a',
                '*.o',
                '*.so',
                '*.out',
            },
        })
    end
}

local toggle_term = {
    'akinsho/toggleterm.nvim',
    lazy = true,
    cmd = {
        'ToggleTerm',
        'ToggleTermSetName',
        'ToggleTermToggleAll',
        'ToggleTermSendVisualLines',
        'ToggleTermSendCurrentLine',
        'ToggleTermSendVisualSelection',
    },
    version = 'v2.*',
    init = function()
        vim.keymap.set('n', '<C-Space>', '<Cmd>ToggleTerm<CR>', {})
        vim.keymap.set('i', '<C-Space>', '<Cmd>ToggleTerm<CR>', {})
    end,
    config = function()
        require('toggleterm').setup({
            open_mapping = [[<C-Space>]],
            insert_mappings = true,
            close_on_exit = true,
            direction = 'float',
        })
    end
}

local which_key = {
    'folke/which-key.nvim',
    lazy = true,
    event = { 'CursorHold', 'CursorHoldI' },
    config = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
        local wk = require('which-key')
        wk.setup({
            popup_mappings = {
                scroll_down = '<c-j>',
                scroll_up = '<c-k>',
            },
            window = {
                border = 'double',
                margin = { 0, 0, 0, 0 },
                padding = { 0, 0, 0, 0 },
            },
            layout = {
                spacing = 1,
            }
        })
        wk.register({
            ['<leader>g'] = {
                name = 'git',
                u = 'unstage hunk',
                h = 'show hunk',
                b = 'blame',
                d = 'diff',
                r = 'restore hunk'
            },
            ['<leader>f'] = {
                name = 'fzf',
                f = 'file',
                g = 'grep',
                b = 'buf',
                h = 'help tags',
            },
            ['<leader>c'] = {
                name = 'comment',
            }
        })
    end,
}

local markdown_preview = {
    'iamcco/markdown-preview.nvim',
    lazy = true,
    ft = 'markdown',
    config = function()
        vim.fn['mkdp#util#install']()
        vim.g.mkdp_preview_options = { disable_sync_scroll = 1 }
        vim.keymap.set('n', '<leader>mt', '<Plug>MarkdownPreviewToggle', {})
    end,
}

return function(plugins)
    plugins[#plugins + 1] = toggle_term
    plugins[#plugins + 1] = telescope
    plugins[#plugins + 1] = which_key
    plugins[#plugins + 1] = markdown_preview
end
