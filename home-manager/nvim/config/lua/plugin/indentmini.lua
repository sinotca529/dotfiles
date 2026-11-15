return {
    'nvimdev/indentmini.nvim',
    event = { 'CursorHold', 'CursorHoldI' },
    config = function()
        -- its current-scope search can walk the whole buffer on every redraw
        require('indentmini').setup({ char = '│', exclude = { 'bigfile' } })
    end,
}
