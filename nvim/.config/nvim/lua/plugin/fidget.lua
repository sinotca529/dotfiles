return {
    'j-hui/fidget.nvim',
    tag = 'legacy',
    lazy = true,
    event = { 'LspAttach' },
    config = function()
        require('fidget').setup({
            timer = {
                task_decay = 0
            },
        })
    end
}
