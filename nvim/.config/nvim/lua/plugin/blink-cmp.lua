return {
    'saghen/blink.cmp',
    version = '*',
    dependencies = {
        'moyiz/blink-emoji.nvim',
    },
    opts = {
        keymap = {
            preset = 'none',
            ['<C-p>'] = { 'select_prev', 'fallback' },
            ['<C-n>'] = { 'select_next', 'fallback' },
            ['<CR>']  = { 'accept', 'fallback' },
            ['<C-q>'] = { 'cancel', 'fallback' },
        },
        sources = {
            default = { 'lsp', 'path', 'snippets', 'buffer', 'emoji' },
            providers = {
                emoji = {
                    module = 'blink-emoji',
                    name = 'Emoji',
                },
            },
        },
        completion = {
            documentation = { auto_show = true },
            menu = {
                auto_show = function(ctx)
                    -- プレーンテキスト系では自動で補完を出さない（<C-n>/<C-p> では出せる）
                    local ft = vim.bo[ctx.bufnr].filetype
                    return not vim.tbl_contains({ 'text', 'markdown', 'gitcommit', '' }, ft)
                end,
            },
        },
        signature = { enabled = true },
    },
    opts_extend = { 'sources.default' },
}
