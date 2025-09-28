return {
  "vim-skk/skkeleton",
  dependencies = { "vim-denops/denops.vim" },
  config = function()
    vim.keymap.set("i", "<C-j>", "<Plug>(skkeleton-enable)")
    vim.keymap.set("c", "<C-j>", "<Plug>(skkeleton-enable)")
    vim.keymap.set("i", "<C-k>", "<Plug>(skkeleton-disable)")
    vim.keymap.set("c", "<C-k>", "<Plug>(skkeleton-disable)")

    vim.fn["skkeleton#config"]({
      globalDictionaries = { "~/.skk/SKK-JISYO.L" },
    })

  end,
}
