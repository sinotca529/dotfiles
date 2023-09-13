return {
    'phaazon/hop.nvim',
    keys = { 'f', 'F', 't', 'T' },
    config = function()
        local hop = require('hop')
        hop.setup()

        local d = require('hop.hint').HintDirection
        local o = { remap = true, silent = true, }
        vim.keymap.set('n', 'f', function() hop.hint_char1({ direction = d.AFTER_CURSOR }) end, o)
        vim.keymap.set('n', 'F', function() hop.hint_char1({ direction = d.BEFORE_CURSOR }) end, o)
        vim.keymap.set('n', 't', function() hop.hint_char1({ direction = d.AFTER_CURSOR, hint_offset = -1 }) end, o)
        vim.keymap.set('n', 'T', function() hop.hint_char1({ direction = d.BEFORE_CURSOR, hint_offset = 1 }) end, o)
    end
}
