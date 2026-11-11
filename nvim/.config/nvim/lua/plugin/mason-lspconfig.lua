return {
    "mason-org/mason-lspconfig.nvim",
    event = "VeryLazy",
    dependencies = {
        "neovim/nvim-lspconfig",
        "mason-org/mason.nvim",
        "saghen/blink.cmp", -- load first: it sets LSP capabilities via vim.lsp.config('*')
    },
    config = function()
        -- capabilities は blink.cmp が vim.lsp.config('*') で自動設定する
        vim.lsp.config("lua_ls", {
          settings = {
            Lua = {
              diagnostics = { globals = { "vim" } },
            },
          },
        })
        require("mason-lspconfig").setup()
    end,
}
