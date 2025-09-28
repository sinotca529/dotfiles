return {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
        'dcampos/nvim-snippy',
        'dcampos/cmp-snippy',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-emoji',
    },
    config = function()
        local snippy = require('snippy')
        snippy.setup({})
        local cmp = require('cmp')
        local has_words_before = function()
            local line, col = table.unpack(vim.api.nvim_win_get_cursor(0))
            return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
        end

        cmp.setup({
            snippet = {
                expand = function(args)
                    snippy.expand_snippet(args.body)
                end
            },
            mapping = {
                ['<C-p>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif snippy.can_jump(-1) then
                        snippy.previous()
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
                ['<C-n>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif snippy.can_expand_or_advance() then
                        snippy.expand_or_advance()
                    elseif has_words_before() then
                        cmp.complete()
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
                ['<CR>'] = cmp.mapping.confirm({ select = true }),
                ['<C-q>'] = cmp.mapping.close(),
            },
            sources = cmp.config.sources({
                { name = 'emoji' },
                { name = 'snippy' },
                { name = 'nvim_lsp' },
                { name = 'buffer' },
            }),
        })
        vim.diagnostic.config({ virtual_text = false })
    end
}
