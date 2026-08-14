return {
    'mfussenegger/nvim-lint',
    ft = 'tex',
    config = function()
        require('lint').linters_by_ft = {
            tex = { 'textlint' },
        }
        vim.api.nvim_create_autocmd({ 'BufWritePost', 'BufReadPost', 'InsertLeave' }, {
            pattern = '*.tex',
            callback = function()
                require('lint').try_lint()
            end,
        })
    end
}
