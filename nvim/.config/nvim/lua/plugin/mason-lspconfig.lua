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

        -- Servers that ship with a language toolchain are used from the system
        -- (rustup / pacman), not mason, so they always match the compiler.
        -- mason-lspconfig only auto-enables mason-installed servers, so enable
        -- these explicitly. Do not install them via mason as well: mason puts
        -- its bin/ first in PATH, so its copy would win.
        vim.lsp.enable({ "rust_analyzer", "clangd" })
    end,
}
