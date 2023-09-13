return {
    'iamcco/markdown-preview.nvim',
    ft = 'markdown',
    config = function()
        vim.fn['mkdp#util#install']()
        vim.g.mkdp_preview_options = { disable_sync_scroll = 1 }
        vim.keymap.set('n', '<leader>mt', '<Plug>MarkdownPreviewToggle', {})
    end,
}
