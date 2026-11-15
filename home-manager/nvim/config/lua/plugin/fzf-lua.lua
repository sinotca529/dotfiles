return {
    'ibhagwan/fzf-lua',
    cmd = 'FzfLua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    init = function()
        vim.keymap.set('n', '<leader>ff', '<Cmd>FzfLua files<CR>', { desc = 'find file' })
        vim.keymap.set('n', '<leader>fg', '<Cmd>FzfLua live_grep<CR>', { desc = 'live grep' })
        vim.keymap.set('n', '<leader>fb', '<Cmd>FzfLua buffers<CR>', { desc = 'buffers' })
        vim.keymap.set('n', '<leader>fh', '<Cmd>FzfLua help_tags<CR>', { desc = 'help tags' })

        -- lspsaga replacement
        vim.keymap.set('n', '<C-.>', '<Cmd>FzfLua lsp_code_actions<CR>', { desc = 'code action' })
        vim.keymap.set('n', '<leader>lsf', '<Cmd>FzfLua lsp_finder<CR>', { desc = 'lsp finder' })
    end,
    config = function()
        require('fzf-lua').setup({
            files = {
                fd_opts = "--type f --type l --follow --exclude .git"
                    .. " --exclude '*.a' --exclude '*.o' --exclude '*.so' --exclude '*.out' --exclude '*.class'",
            },
            keymap = {
                fzf = {
                    ['ctrl-j'] = 'down',
                    ['ctrl-k'] = 'up',
                },
            },
        })
    end
}
