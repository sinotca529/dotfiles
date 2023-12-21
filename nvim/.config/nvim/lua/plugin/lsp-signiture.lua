return {
    'ray-x/lsp_signature.nvim',
    event = 'LspAttach',
    config = function()
        require('lsp_signature').on_attach({
            hint_prefix = " "
        })
    end,
}
