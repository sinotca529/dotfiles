return {
    use_arg_list = {
        {'Mofiqul/vscode.nvim'}
    },
    init = function()
        require('vscode').setup({})
        vim.cmd('colorscheme vscode')
    end
}

