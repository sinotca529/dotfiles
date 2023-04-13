local function telescope()
    return {
        'nvim-telescope/telescope.nvim',
        version = '0.1.0',
        dependencies = { 'nvim-lua/plenary.nvim' },
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
            })
            local bi = require('telescope.builtin')
            vim.keymap.set('n', '<leader>ff', bi.find_files, {})
            vim.keymap.set('n', '<leader>fg', bi.live_grep, {})
            vim.keymap.set('n', '<leader>fb', bi.buffers, {})
            vim.keymap.set('n', '<leader>fh', bi.help_tags, {})
        end
    }
end

local function toggle_term()
    return {
        'akinsho/toggleterm.nvim',
        version = 'v2.*',
        config = function()
            require("toggleterm").setup({
                open_mapping = [[<C-@>]],
                insert_mappings = true,
                close_on_exit = true,
                direction = 'float',
            })
        end
    }
end

local function which_key()
    return {
        'folke/which-key.nvim',
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
                }

            })
        end,
    }
end

return function(plugins)
    plugins[#plugins + 1] = toggle_term()
    plugins[#plugins + 1] = telescope()
    plugins[#plugins + 1] = which_key()
    -- nvim_tree(use)
end
