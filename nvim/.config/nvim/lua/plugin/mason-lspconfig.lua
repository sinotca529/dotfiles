return {
    "mason-org/mason-lspconfig.nvim",
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
    dependencies = {
        "neovim/nvim-lspconfig",
        "mason-org/mason.nvim",
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
