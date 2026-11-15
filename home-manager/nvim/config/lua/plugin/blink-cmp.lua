return {
    'saghen/blink.cmp',
    version = '*',
    event = 'VeryLazy',
    dependencies = {
        'moyiz/blink-emoji.nvim',
    },
    opts = {
        keymap = {
            preset = 'none',
            -- メニューが出ていなければ blink のメニューを出す（auto_show を切っている filetype 用）
            ['<C-p>'] = { 'select_prev', 'show', 'fallback' },
            ['<C-n>'] = { 'select_next', 'show', 'fallback' },
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
