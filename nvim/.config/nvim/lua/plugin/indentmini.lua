return {
    'nvimdev/indentmini.nvim',
    event = { 'CursorHold', 'CursorHoldI' },
    config = function()
        require('indentmini').setup({ char = '│', })
        vim.cmd.highlight('default link IndentLine IndentBlanklineChar')
    end,
}
