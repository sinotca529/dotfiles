return {
    'glepnir/zephyr-nvim',
    dependencies = {
        'gnmearacaun/zephyr-clear.nvim',
        'https://github.com/catppuccin/nvim'
    },
    config = function()
        if vim.env.TERMINAL_THEME == "light" then
            vim.cmd.colorscheme('catppuccin-latte')
        else
            vim.cmd.colorscheme('zephyr_clear')
            vim.cmd.highlight('IndentLine guifg=#333333')
            vim.cmd.highlight('IndentLineCurrent guifg=#333333')
            vim.cmd.highlight('NormalFloat guifg=#bbc2cf guibg=#000000')
        end
    end
}
