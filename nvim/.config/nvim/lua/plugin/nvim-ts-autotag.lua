return {
    'windwp/nvim-ts-autotag',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    ft = 'html',
    config = function()
      require('nvim-ts-autotag').setup()
    end,
}
