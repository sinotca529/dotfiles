return {
    'NMAC427/guess-indent.nvim',
    event = { 'CursorHold', 'CursorHoldI' },
    config = function()
        require('guess-indent').setup({
            override_editorconfig = true,
        })
    end
}
