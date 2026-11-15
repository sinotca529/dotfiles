-- `nvim <dir>` relies on nvim-tree's own VimEnter hook to auto-open the tree,
-- which requires setup() to have already run by VimEnter. Load eagerly only
-- in that case; otherwise defer to whatever actually opens it.
local function opening_dir()
    return vim.fn.argc(-1) == 1 and vim.fn.isdirectory(vim.fn.argv(0, -1)) == 1
end

return {
    'nvim-tree/nvim-tree.lua',
    cmd = { 'NvimTreeToggle', 'NvimTreeOpen', 'NvimTreeFocus', 'NvimTreeFindFile' },
    -- bind to an explicit command rather than a bare key: setup() alone never
    -- calls on_attach (that only fires once the tree is actually opened), so
    -- a bare `keys = '<C-h>'` trigger would load the plugin but open nothing.
    keys = {
        { '<C-h>', '<cmd>NvimTreeToggle<CR>', desc = 'toggle sidebar' },
    },
    lazy = not opening_dir(),
    dependencies = {
        'nvim-tree/nvim-web-devicons',
    },
    config = function()
        require('nvim-tree').setup({
            sort = {
                sorter = 'extension',
            },
            view = {
              float = {
                enable = true,
                open_win_config = function()
                  local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
                  return {
                    border = 'single',
                    relative = 'editor',
                    row = 0,
                    col = 0,
                    width = 40,
                    height = screen_h - 3,  -- prevent hiding status line
                  }
                  end,
              },
              width = 40,
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
                local function opts(desc)
                    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
                end

                local api = require('nvim-tree.api')
                vim.keymap.set('n', '<C-h>', api.tree.toggle, { desc = 'toggle sidebar' })
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
