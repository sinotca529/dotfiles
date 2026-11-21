-- Hyprland 0.57 以降の設定 (Lua)。旧 hyprland.conf から移植。
-- API の定義: /usr/share/hypr/stubs/hl.meta.lua
-- 書式の例:   /usr/share/hypr/hyprland.lua
-- 確認方法:   Hyprland --verify-config -c ~/.config/hypr/hyprland.lua

local kiten   = "~/.config/hypr/tools/kiten/kiten.sh"
local keyhelp = "~/.config/hypr/tools/keyhelp/keyhelp.sh"

-- Nord (https://www.nordtheme.com/docs/colors-and-palettes)
-- waybar/style.css, mako/config, foot/foot.ini も同じパレットで揃えている
local nord = {
    polar3 = "4c566a",
    frost1 = "88c0d0", frost3 = "5e81ac",
}
local function rgba(hex, a) return "rgba(" .. hex .. a .. ")" end

-----------------
---- MONITOR ----
-----------------

hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = "auto",
})

-------------
---- ENV ----
-------------

hl.env("XCURSOR_SIZE", "24")
hl.env("QT_IM_MODULE", "fcitx")
hl.env("XMODIFIERS", "@im=fcitx")
hl.env("CHROME_USER_FLAGS", "--gtk-version=4")

---------------------------
---- LOOK, FEEL, INPUT ----
---------------------------

hl.config({
    input = {
        kb_layout  = "jp,us",
        kb_variant = "",
        kb_model   = "",
        kb_rules   = "",

        follow_mouse = 2,
        sensitivity  = 0,

        touchpad = {
            natural_scroll       = true,
            disable_while_typing = true,
        },
    },

    general = {
        gaps_in     = 5,
        gaps_out    = 10,
        border_size = 2,
        col = {
            active_border   = { colors = { rgba(nord.frost1, "ee"), rgba(nord.frost3, "ee") }, angle = 45 },
            inactive_border = rgba(nord.polar3, "aa"),
        },
        resize_on_border = true,
        layout = "dwindle",
    },

    decoration = {
        rounding = 5,
        blur = {
            enabled = true,
            size    = 3,
            passes  = 1,
        },
        shadow = {
            color = rgba("1a1a1a", "ee"),
        },
    },

    animations = {
        enabled = false,
    },

    dwindle = {
        preserve_split = true,
    },

    master = {
        new_status = "master",
    },

    misc = {
        -- 壁紙プロセスを動かさず、黒で塗るだけにする (軽量)。
        -- Nord の地色にすると foot (同じ色) と区別がつかないので黒のまま。
        force_default_wallpaper = 0,
        disable_hyprland_logo   = true,
        background_color        = rgba("000000", "ff"),
    },
})

-- 4 本指の左右スワイプでワークスペース移動
hl.gesture({ fingers = 4, direction = "left",  action = "workspace" })
hl.gesture({ fingers = 4, direction = "right", action = "workspace" })

-----------------------
---- WINDOW RULES ----
-----------------------

-- ファイルダイアログ類はフロート
for _, title in ipairs({
    "Open",
    "Choose Files",
    "Save As",
    "Confirm to replace files",
    "File Operation Progress",
}) do
    hl.window_rule({ match = { title = "^(" .. title .. ")$" }, float = true })
end

-- ランチャー (Kiten)
hl.window_rule({
    name   = "kiten",
    match  = { title = "^(Kiten)$" },
    float  = true,
    size   = "monitor_w*0.4 monitor_h*0.2",
    center = true,
})

-- ショートカット早見表 (SUPER + /)
hl.window_rule({
    name   = "keyhelp",
    match  = { title = "^(Keys)$" },
    float  = true,
    size   = "monitor_w*0.45 monitor_h*0.6",
    center = true,
})

-- waybar の背面をぼかす
hl.layer_rule({
    name         = "waybar-blur",
    match        = { namespace = "^waybar$" },
    blur         = true,
    ignore_alpha = 0,
})

---------------------
---- KEYBINDINGS ----
---------------------

-- 全 bind に desc を付けること。早見表 (tools/keyhelp) は
-- `hyprctl binds -j` の desc を表示するので、desc の無い bind は載らない。
-- 隣り合う bind の desc と修飾キーが同じなら、早見表では 1 行にまとまる。
-- desc は「分類: 内容」の形にしておくと、早見表で分類名でも絞り込める。

local mainMod = "SUPER"
local function key(k) return mainMod .. " + " .. k end
local function toggle(title, script)
    return hl.dsp.exec_cmd("pkill -f " .. script .. " || foot --title " .. title .. " " .. script)
end

hl.bind(key("slash"),       toggle("Keys", keyhelp),             { desc = "ヘルプ: ショートカット一覧" })
hl.bind(key("SPACE"),       toggle("Kiten", kiten),              { desc = "起動: ランチャー (=式 で計算)" })
hl.bind(key("Q"),           hl.dsp.exec_cmd("foot"),             { desc = "起動: ターミナル (foot)" })
hl.bind(key("E"),           hl.dsp.exec_cmd("thunar"),           { desc = "起動: ファイラ (thunar)" })

hl.bind(key("F4"),          hl.dsp.window.close(),               { desc = "ウィンドウ: 閉じる" })
hl.bind(key("V"),           hl.dsp.window.float({ action = "toggle" }), { desc = "ウィンドウ: フロート切替" })
hl.bind(key("P"),           hl.dsp.window.pseudo(),              { desc = "ウィンドウ: 擬似タイル切替" })
hl.bind(key("mouse:272"),   hl.dsp.window.drag(),                { mouse = true, desc = "ウィンドウ: ドラッグで移動" })

-- vim 風のフォーカス移動 / ウィンドウ移動
local dirs = {
    { "H", "left",  "←" },
    { "J", "down",  "↓" },
    { "K", "up",    "↑" },
    { "L", "right", "→" },
}
for _, d in ipairs(dirs) do
    hl.bind(key(d[1]), hl.dsp.focus({ direction = d[2] }), { desc = "フォーカス: " .. d[3] .. " (hjkl)" })
end
for _, d in ipairs(dirs) do
    hl.bind(key("SHIFT + " .. d[1]), hl.dsp.window.move({ direction = d[2] }), { desc = "ウィンドウ: " .. d[3] .. " へ移動 (hjkl)" })
end

hl.bind(key("minus"), hl.dsp.layout("splitratio -0.1"), { repeating = true, desc = "ウィンドウ: 分割比を縮める" })
hl.bind(key("equal"), hl.dsp.layout("splitratio +0.1"), { repeating = true, desc = "ウィンドウ: 分割比を広げる" })

-- タブ (グループ)
hl.bind(key("T"), hl.dsp.group.toggle(), { desc = "タブ: グループ化の切替" })
hl.bind(key("N"), hl.dsp.group.next(),   { desc = "タブ: 次のタブへ" })

-- SUPER + [0-9] でワークスペース切替、SUPER + CTRL + [0-9] でウィンドウを静かに移動
-- (早見表で 1 行にまとめるため、ループを分けて同じ desc を連続させる)
for i = 1, 10 do
    hl.bind(key(tostring(i % 10)), hl.dsp.focus({ workspace = i }), { desc = "ワークスペース: 番号へ切替" })
end
for i = 1, 10 do
    hl.bind(key("CONTROL + " .. tostring(i % 10)), hl.dsp.window.move({ workspace = i, follow = false }),
        { desc = "ワークスペース: ウィンドウを番号へ送る" })
end
hl.bind(key("CONTROL + K"), hl.dsp.focus({ workspace = "+1" }),        { desc = "ワークスペース: 次へ" })
hl.bind(key("CONTROL + J"), hl.dsp.focus({ workspace = "-1" }),        { desc = "ワークスペース: 前へ" })
hl.bind(key("TAB"),         hl.dsp.focus({ workspace = "previous" }),  { desc = "ワークスペース: 直前のへ戻る" })

-- 特殊キー
hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%+"), { repeating = true, desc = "メディア: 音量 +" })
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-"), { repeating = true, desc = "メディア: 音量 -" })
hl.bind("XF86AudioMute",         hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),   { desc = "メディア: ミュート" })
hl.bind("XF86AudioMicMute",      hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { desc = "メディア: マイクミュート" })
hl.bind("XF86AudioPlay",         hl.dsp.exec_cmd("playerctl play-pause"), { desc = "メディア: 再生/停止" })
hl.bind("XF86AudioNext",         hl.dsp.exec_cmd("playerctl next"),       { desc = "メディア: 次の曲" })
hl.bind("XF86AudioPrev",         hl.dsp.exec_cmd("playerctl previous"),   { desc = "メディア: 前の曲" })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 1%-"), { repeating = true, desc = "システム: 画面を暗く" })
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl set 1%+"), { repeating = true, desc = "システム: 画面を明るく" })

hl.bind(key("SHIFT + S"), hl.dsp.exec_cmd('grim -g "$(slurp)" - | wl-copy'), { desc = "システム: 範囲スクショ → クリップボード" })
hl.bind(key("R"),         hl.dsp.exec_cmd("killall waybar; waybar & disown"), { desc = "システム: waybar 再起動" })
hl.bind(key("SHIFT + E"), hl.dsp.exit(), { desc = "システム: Hyprland 終了 (ログアウト)" })

-- ロックモード: SUPER + G で入り、他のキーを無効化。もう一度 SUPER + G で抜ける
hl.bind(key("G"), hl.dsp.submap("LOCK"), { desc = "システム: キー入力ロック (もう一度で解除)" })
hl.define_submap("LOCK", function()
    hl.bind(key("G"), hl.dsp.submap("reset"), { desc = "ロック解除" })
end)

-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function()
    hl.exec_cmd("waybar")
    hl.exec_cmd("mako")
    hl.exec_cmd("fcitx5")
    hl.exec_cmd("copyq --start-server")
end)
