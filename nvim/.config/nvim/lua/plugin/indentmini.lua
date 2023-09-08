return {
    'nvimdev/indentmini.nvim',
    event = 'BufEnter',
    config = function()
        require('indentmini').setup({ char = '│', })
        vim.cmd.highlight('default link IndentLine IndentBlanklineChar')
    end,
}
