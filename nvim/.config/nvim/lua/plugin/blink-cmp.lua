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
        },
        signature = { enabled = true },
    },
    opts_extend = { 'sources.default' },
}
