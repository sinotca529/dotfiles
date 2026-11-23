-- Claude Code の IDE 連携(VS Code 拡張と同じプロトコル)。
-- nvim 側で WebSocket サーバを立て、選択範囲や開いているファイルを Claude に伝える。
-- claude は toggleterm の専用フローティングターミナルで動かす(<M-c> で開閉)。
-- 別の tmux pane で起動した claude から `/ide` で接続することもできる。

-- claude 専用のターミナル。最初に開くときに作る(サーバのポートが決まってから env に渡すため)
local claude_term

local function toggle_claude()
    if not claude_term then
        -- claudecode.nvim 自身のターミナルと同じ環境変数を渡すと、/ide なしでこの nvim に接続する
        local env = {}
        local port = require('claudecode').state.port
        if port then
            env.ENABLE_IDE_INTEGRATION = 'true'
            env.CLAUDE_CODE_SSE_PORT = tostring(port)
        end
        claude_term = require('toggleterm.terminal').Terminal:new({
            cmd = 'claude',
            env = env,
            hidden = true, -- <C-Space> の汎用ターミナルとは別扱いにする
            direction = 'float',
            close_on_exit = true,
            float_opts = {
                border = 'curved',
                width = function() return math.floor(vim.o.columns * 0.9) end,
                height = function() return math.floor(vim.o.lines * 0.9) end,
            },
        })
    end
    claude_term:toggle()
end

return {
    'coder/claudecode.nvim',
    -- 起動直後からサーバを立てておかないと /ide で見つからないので、keys での遅延読み込みはしない
    event = 'VeryLazy',
    opts = {
        diff_opts = {
            -- tmux で左右分割していると左右の diff は狭いので、1 画面に削除行と追加行を交互に並べる
            layout = 'unified',
            -- 現在のタブで開くと元のウィンドウの横に split されるので、新しいタブに全幅で開く
            -- (フローティングウィンドウはタブごとなので、claude のターミナルも diff に被らない)
            open_in_new_tab = true,
        },
    },
    keys = {
        -- ターミナル内からも閉じられるよう t モードにも割り当てる。
        -- <leader> は claude への入力(スペース)と衝突し、<C-\> は <C-\><C-n> を潰すので Alt を使う
        { '<M-c>', toggle_claude, mode = { 'n', 'i', 't' }, desc = 'Claude: ターミナルを開閉' },
        { '<leader>aa', '<Cmd>ClaudeCodeDiffAccept<CR>', desc = 'Claude: diff を受け入れる' },
        { '<leader>ad', '<Cmd>ClaudeCodeDiffDeny<CR>',   desc = 'Claude: diff を却下する' },
    },
}
