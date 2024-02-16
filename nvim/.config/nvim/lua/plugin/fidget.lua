return {
    'j-hui/fidget.nvim',
    event = 'LspAttach',
    config = function()
        require('fidget').setup({
            timer = {
                task_decay = 0
            },
        })
    end
}
