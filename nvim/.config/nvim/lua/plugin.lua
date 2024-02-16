local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    local lazy_repo = 'https://github.com/folke/lazy.nvim.git '
    vim.api.nvim_command('!git clone --filter=blob:none --branch=stable ' .. lazy_repo .. lazypath)
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup(
    {
        -- appearance
        require('plugin.color-scheme'),
        require('plugin.indentmini'),
        require('plugin.guess-indent'),
        require('plugin.nvim-treesitter'),
        require('plugin.lualine'),
        require('plugin.colorizer'),
        require('plugin.todo-comments'),

        -- lsp, cmp
        require('plugin.mason'),
        require('plugin.mason-lspconfig'),
        require('plugin.null-ls'),
        require('plugin.mason-null-ls'),
        require('plugin.nvim-cmp'),
        require('plugin.fidget'),
        require('plugin.lsp-saga'),
        require('plugin.lsp-signiture'),
        require('plugin.nvim-autopairs'),
        require('plugin.trouble'),

        -- git
        require('plugin.git-signs'),

        -- tool
        require('plugin.nvim-tree'),
        require('plugin.toggle-term'),
        require('plugin.telescope'),
        require('plugin.which-key'),
        require('plugin.md-preview'),
        require('plugin.hop'),
        require('plugin.ssr'),
        require('plugin.surround'),
        require('plugin.comment'),

        --- tex
        require('plugin.vimtex'),

        --- debug
        require('plugin.dap'),
        require('plugin.nvim-dap-lsp'),
    },
    {
        ui = {
            border = 'rounded'
        },
    }
)
