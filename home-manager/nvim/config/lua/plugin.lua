local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
    local lazy_repo = 'https://github.com/folke/lazy.nvim.git '
    vim.api.nvim_command('!git clone --filter=blob:none --branch=stable ' .. lazy_repo .. lazypath)
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup(
    {
        -- foundation: 他のプラグインが依存する土台
        require('plugin.denops'),          -- skkeleton
        require('plugin.nvim-treesitter'), -- treesitter-context, nvim-ts-autotag

        -- ui: 画面に情報を表示するだけで、テキストには触れない
        require('plugin.color-scheme'),
        require('plugin.indentmini'),
        require('plugin.treesitter-context'),
        require('plugin.todo-comments'),
        require('plugin.which-key'),

        -- editing: テキストを入力・変形する
        require('plugin.guess-indent'),
        require('plugin.nvim-autopairs'),
        require('plugin.nvim-ts-autotag'),
        require('plugin.surround'),
        require('plugin.ssr'),
        require('plugin.skkeleton'),

        -- navigation: カーソル・ファイル間を移動する
        require('plugin.hop'),
        require('plugin.fzf-lua'),
        require('plugin.nvim-tree'),

        -- language intelligence: LSP / 補完 / lint / format
        require('plugin.mason'),
        require('plugin.mason-lspconfig'),
        require('plugin.blink-cmp'),
        require('plugin.nvim-lint'),
        require('plugin.conform'),

        -- debug
        require('plugin.dap'),
        require('plugin.nvim-dap-lsp'),

        -- git
        require('plugin.git-signs'),
        require('plugin.git-conflict'),

        -- ai
        require('plugin.ollama'),
        require('plugin.gh-copilot'),
        require('plugin.claudecode'),

        -- filetype: 特定のファイル種別でだけ使う
        require('plugin.vimtex'),
        require('plugin.md-preview'),
        require('plugin.maketable'),

        -- external: nvim の外のものを呼び出す
        require('plugin.toggle-term'),
    },
    {
        ui = {
            border = 'rounded'
        },
        -- luarocks を必要とするプラグインはないので無効にする
        rocks = {
            enabled = false,
        },
    }
)
