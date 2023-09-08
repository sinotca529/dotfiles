return {
    'sainnhe/gruvbox-material',
    lazy = false,
    dependencies = {
        'edeneast/nightfox.nvim',
        'glepnir/zephyr-nvim',
        'vigoux/oak',
        'catppuccin/nvim',
    },
    config = function()
        vim.cmd.colorscheme('gruvbox-material')
        vim.cmd('hi Comment cterm=NONE')
        vim.cmd('hi Comment gui=NONE')
        vim.cmd('hi Normal ctermbg=NONE guibg=#NONE')
        vim.cmd('hi NormalNC ctermbg=NONE guibg=#NONE')
        vim.cmd('hi NonText ctermbg=NONE guibg=#NONE')
        vim.cmd('hi LineNr ctermbg=NONE guibg=#NONE')
        vim.cmd('hi Folded ctermbg=NONE guibg=#NONE')
        vim.cmd('hi EndOfBuffer ctermbg=NONE guibg=#NONE')
    end
}
