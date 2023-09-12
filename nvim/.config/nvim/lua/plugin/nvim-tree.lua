return {
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
            renderer = {
                group_empty = true,
                highlight_git = true,
                icons = {
                    show = { git = false }
                }
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
