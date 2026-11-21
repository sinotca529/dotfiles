-- Hyprland 0.57 以降の設定 (Lua)。旧 hyprland.conf から移植。
-- API の定義: /usr/share/hypr/stubs/hl.meta.lua
-- 書式の例:   /usr/share/hypr/hyprland.lua
-- 確認方法:   Hyprland --verify-config -c ~/.config/hypr/hyprland.lua

local kiten = "~/.config/hypr/tools/kiten/kiten.sh"

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
            active_border   = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
            inactive_border = "rgba(595959aa)",
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
            color = "rgba(1a1a1aee)",
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
        force_default_wallpaper = 0,
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

---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER"
local function key(k) return mainMod .. " + " .. k end

hl.bind(key("F4"),          hl.dsp.window.close())
hl.bind(key("SHIFT + E"),   hl.dsp.exit())
hl.bind(key("V"),           hl.dsp.window.float({ action = "toggle" }))
hl.bind(key("SPACE"),       hl.dsp.exec_cmd("pkill -f " .. kiten .. " || foot --title Kiten " .. kiten))
hl.bind(key("P"),           hl.dsp.window.pseudo())
hl.bind(key("TAB"),         hl.dsp.focus({ workspace = "previous" }))

-- vim 風のフォーカス移動 / ウィンドウ移動
local dirs = { H = "left", L = "right", K = "up", J = "down" }
for k, dir in pairs(dirs) do
    hl.bind(key(k),             hl.dsp.focus({ direction = dir }))
    hl.bind(key("SHIFT + " .. k), hl.dsp.window.move({ direction = dir }))
end

-- SUPER + [0-9] でワークスペース切替、SUPER + CTRL + [0-9] でウィンドウを静かに移動
for i = 1, 10 do
    local n = tostring(i % 10)
    hl.bind(key(n),             hl.dsp.focus({ workspace = i }))
    hl.bind(key("CONTROL + " .. n), hl.dsp.window.move({ workspace = i, follow = false }))
end

hl.bind(key("CONTROL + K"), hl.dsp.focus({ workspace = "+1" }))
hl.bind(key("CONTROL + J"), hl.dsp.focus({ workspace = "-1" }))

hl.bind(key("minus"), hl.dsp.layout("splitratio -0.1"), { repeating = true })
hl.bind(key("equal"), hl.dsp.layout("splitratio +0.1"), { repeating = true })

-- SUPER + 左ドラッグでウィンドウ移動
hl.bind(key("mouse:272"), hl.dsp.window.drag(), { mouse = true })

-- 特殊キー
hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%+"),     { repeating = true })
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-"),     { repeating = true })
hl.bind("XF86AudioMute",         hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))
hl.bind("XF86AudioMicMute",      hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"))
hl.bind("XF86AudioPlay",         hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioNext",         hl.dsp.exec_cmd("playerctl next"))
hl.bind("XF86AudioPrev",         hl.dsp.exec_cmd("playerctl previous"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 1%-"), { repeating = true })
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl set 1%+"), { repeating = true })

-- スクリーンショット
hl.bind(key("SHIFT + S"), hl.dsp.exec_cmd('grim -g "$(slurp)" - | wl-copy'))

-- Waybar 再起動
hl.bind(key("R"), hl.dsp.exec_cmd("killall waybar; waybar & disown"))

-- 起動
hl.bind(key("Q"), hl.dsp.exec_cmd("foot"))
hl.bind(key("E"), hl.dsp.exec_cmd("thunar"))

-- ロックモード: SUPER + G で入り、他のキーを無効化。もう一度 SUPER + G で抜ける
hl.bind(key("G"), hl.dsp.submap("LOCK"))
hl.define_submap("LOCK", function()
    hl.bind(key("G"), hl.dsp.submap("reset"))
end)

-- タブ (グループ)
hl.bind(key("T"), hl.dsp.group.toggle())
hl.bind(key("N"), hl.dsp.group.next())

-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function()
    hl.exec_cmd("waybar")
    hl.exec_cmd("mako")
    hl.exec_cmd("fcitx5")
    hl.exec_cmd("copyq --start-server")
end)
