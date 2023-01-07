local function telescope()
    return {
        'nvim-telescope/telescope.nvim',
        version = '0.1.0',
        dependencies = {'nvim-lua/plenary.nvim'},
        config = {
            vim.keymap.set('n', 'ff', '<cmd>Telescope find_files<CR>')
        }
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

return function(plugins)
    plugins[#plugins+1] = toggle_term()
    plugins[#plugins+1] = telescope()
    -- nvim_tree(use)
end
