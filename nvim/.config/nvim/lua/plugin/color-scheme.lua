return {
    'glepnir/zephyr-nvim',
    dependencies = {
        'gnmearacaun/zephyr-clear.nvim',
    },
    config = function()
        vim.cmd.colorscheme('zephyr_clear')
        vim.cmd.highlight('IndentLine guifg=#333333')
        vim.cmd.highlight('IndentLineCurrent guifg=#333333')
    end
}
