return {
    'ray-x/lsp_signature.nvim',
    lazy = true,
    event = 'LspAttach',
    config = function()
        require('lsp_signature').on_attach()
    end,
}
