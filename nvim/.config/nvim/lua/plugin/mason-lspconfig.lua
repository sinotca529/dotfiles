return {
    "mason-org/mason-lspconfig.nvim",
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
    dependencies = {
        "neovim/nvim-lspconfig",
        "mason-org/mason.nvim",
        "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
        -- 1) サーバ定義は nvim コアの API で
        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        vim.lsp.config("lua_ls", {
          capabilities = capabilities,
          settings = {
            Lua = {
              diagnostics = { globals = { "vim" } },
            },
          },
        })
        require("mason-lspconfig").setup()
    end,
}
