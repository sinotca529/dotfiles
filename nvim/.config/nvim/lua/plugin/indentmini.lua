return {
    'nvimdev/indentmini.nvim',
    event = { 'CursorHold', 'CursorHoldI' },
    config = function()
        require('indentmini').setup({ char = '│', })
    end,
}
