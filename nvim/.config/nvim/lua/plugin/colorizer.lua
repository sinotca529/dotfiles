return {
    'norcalli/nvim-colorizer.lua',
    event = { 'CursorHold', 'CursorHoldI' },
    config = function()
        require('colorizer').setup()
    end,
}
