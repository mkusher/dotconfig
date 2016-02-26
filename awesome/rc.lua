-- Modules {{{
local gears         = require("gears")
local awful         = require("awful")
awful.rules         = require("awful.rules")
                      require("awful.autofocus")
local wibox         = require("wibox")
local beautiful     = require("beautiful")
local vicious       = require("vicious")
local naughty       = require("naughty")
local lain          = require("lain")
local cyclefocus    = require('cyclefocus')
local menubar       = require("menubar")
local bashets       = require("bashets")
                      require("conky")
-- }}}
-- Theme {{{
beautiful.init(os.getenv("HOME") .. "/.config/awesome/theme/theme.lua")
-- }}}
-- Table of layouts {{{

local layouts =
{
    --awful.layout.suit.floating,
    awful.layout.suit.tile,
    --awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    --awful.layout.suit.tile.top
}
-- }}}
-- Markup {{{
local panel = require("panel")
-- }}}
-- Wallpaper {{{

if beautiful.wallpapers then
    local current_wallpaper = 0
    local wallpapers = 4
    local function update_wallpaper()
        local wallpaper = beautiful.wallpapers .. tostring(current_wallpaper + 1) .. ".jpg"
        current_wallpaper = (current_wallpaper + 1) % wallpapers
        for s = 1, screen.count() do
            gears.wallpaper.maximized(wallpaper, s, true)
        end
    end
    local ticker = timer({ timeout = 240 })
    ticker:connect_signal("timeout",
    function()
        update_wallpaper()
    end
    )
    update_wallpaper()
    ticker:start()
end

-- }}}
-- Notifications {{{
--naughty.config.defaults.timeout          = 5
naughty.config.defaults.screen           = 1
naughty.config.defaults.position         = "bottom_right"
naughty.config.defaults.margin           = 4
naughty.config.defaults.height           = 100
naughty.config.defaults.width            = 250
--naughty.config.defaults.gap              = 1
--naughty.config.defaults.ontop            = true
naughty.config.defaults.font             = beautiful.font or "Verdana 8"
--naughty.config.defaults.icon             = nil
naughty.config.defaults.icon_size        = 16
naughty.config.defaults.fg               = beautiful.fg_focus or '#ffffff'
naughty.config.defaults.bg               = beautiful.bg_focus or '#535d6c'
--naughty.config.presetss.border_color     = beautiful.border_focus or '#535d6c'
--naughty.config.defaults.border_width     = 1
--naughty.config.defaults.hover_timeout    = nil
-- }}}
-- Tags {{{

tags = {}
for s = 1, screen.count() do
    tags[s] = awful.tag({ " α ", " β ", " γ ", " δ ", " ε ", " ζ ", " η ", " θ " }, s, layouts[1])
end

-- }}}
-- Variables {{{
browser = os.getenv("BROWSER") or "chromium"
term = "termite"
-- }}}
-- Menu {{{

awesome_menu = {
    { "hibernate", "sudo pm-hibernate" },
    { "poweroff",  "sudo poweroff"     },
    { "restart",   awesome.restart     },
    { "reboot",    "sudo reboot"       },
    { "quit",      awesome.quit        }}

    mainmenu = awful.menu({ items = {
        { " awesome",       awesome_menu   },
        { " terminal",      term       },
        { " chrome",        browser        }
    }})

    -- }}}
-- Caps Lock Keyboard Layout {{{
os.execute("setxkbmap -layout 'us,ru' -option 'grp:caps_toggle,grp_led:caps'")
-- }}}
-- Error handling {{{

if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = err })
        in_error = false
    end)
end

--- }}}
-- Java GUI's fix {{{

awful.util.spawn_with_shell("wmname LG3D")

-- }}}
-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
awful.button({ }, 3, function () mainmenu:toggle() end),
awful.button({ }, 4, awful.tag.viewnext),
awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}
-- {{{ Key bindings
function minimize_all()
    local clients = awful.tag.selected():clients()
    local i = 0
    local shouldMinimize = false
    for i=1, #clients do
        if clients[i].minimized == false then
            shouldMinimize = true
        end
    end
    for i=1, #clients do
        pcall(function()
            clients[i].minimized = shouldMinimize
            clients[i]:redraw()
        end)
    end
end
modkey = "Mod1"
globalkeys = awful.util.table.join(
awful.key({ modkey,           }, "Left",          awful.tag.viewprev                  ),
awful.key({ modkey,           }, "Right",         awful.tag.viewnext                  ),
awful.key({ modkey,           }, "Escape",        awful.tag.history.restore           ),
awful.key({ modkey,           }, "j",
function ()
    awful.client.focus.byidx( 1)
    if client.focus then client.focus:raise() end
end),
awful.key({ modkey,           }, "k",
function ()
    awful.client.focus.byidx(-1)
    if client.focus then client.focus:raise() end
end),
-- Layout manipulation {{{
awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
awful.key({ modkey,           }, "Tab",
function ()
    awful.client.focus.history.previous()
    if client.focus then
        client.focus:raise()
    end
end),
--awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),
-- }}}
-- Standard program {{{
awful.key({ modkey, "Control" }, "r", awesome.restart),
awful.key({ modkey, "Shift"   }, "q", awesome.quit),
awful.key({ modkey, "Control" }, "n", awful.client.restore),
-- }}}
-- Prompt {{{
awful.key({ modkey },            "r",     function () mypromptbox[mouse.screen]:run() end),

awful.key({ modkey }, "x",
function ()
    awful.prompt.run({ prompt = "Run Lua code: " },
    mypromptbox[mouse.screen].widget,
    awful.util.eval, nil,
    awful.util.getdir("cache") .. "/history_eval")
end),
-- }}}
-- Applications {{{
awful.key({ modkey,            }, "w", function () awful.util.spawn("neovim-gui") end),
awful.key({ modkey,            }, "l", function () awful.util.spawn("xscreensaver-command --lock") end),
awful.key({ modkey,            }, "e", function () awful.util.spawn("pcmanfm") end),
awful.key({ modkey,            }, "Return", function () awful.util.spawn(term) end),
awful.key({                    }, "Print", function () awful.util.spawn("deepin-screenshot") end),
awful.key({                    }, "F10", function() raise_conky() end, function() lower_conky() end),
awful.key({ modkey,            }, "d", function() minimize_all() end),
-- }}}
-- Menubar {{{
awful.key({ modkey }, "p", function() menubar.show() end)
-- }}}
)
-- Client {{{
clientkeys = awful.util.table.join(
awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
awful.key({ modkey,           }, "q",      function (c) c:kill()                         end),
awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
awful.key({ modkey,           }, "n",
function (c)
    -- The client currently has the input focus, so it cannot be
    -- minimized, since minimized clients can't have the focus.
    c.minimized = true
end),
awful.key({ modkey,           }, "a",
function (c)
    c.maximized_horizontal = not c.maximized_horizontal
    c.maximized_vertical   = not c.maximized_vertical
end)
)
--- }}}
-- Tags {{{
-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 8 do
    globalkeys = awful.util.table.join(globalkeys,
    -- View tag only.
    awful.key({ modkey }, "#" .. i + 9,
    function ()
        local screen = mouse.screen
        local tag = awful.tag.gettags(screen)[i]
        if tag then
            awful.tag.viewonly(tag)
        end
    end),
    -- Toggle tag.
    awful.key({ modkey, "Control" }, "#" .. i + 9,
    function ()
        local screen = mouse.screen
        local tag = awful.tag.gettags(screen)[i]
        if tag then
            awful.tag.viewtoggle(tag)
        end
    end),
    -- Move client to tag.
    awful.key({ modkey, "Shift" }, "#" .. i + 9,
    function ()
        if client.focus then
            local tag = awful.tag.gettags(client.focus.screen)[i]
            if tag then
                awful.client.movetotag(tag)
            end
        end
    end),
    -- Toggle tag.
    awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
    function ()
        if client.focus then
            local tag = awful.tag.gettags(client.focus.screen)[i]
            if tag then
                awful.client.toggletag(tag)
            end
        end
    end))
end
-- }}}
clientbuttons = awful.util.table.join(
awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
awful.button({ modkey }, 1, awful.mouse.client.move),
awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}
-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
    properties = { border_width = beautiful.border_width,
    border_color = beautiful.border_normal,
    focus = awful.client.focus.filter,
    raise = true,
    keys = clientkeys,
    buttons = clientbuttons } },
    { rule = { class = "plaidchat" },
    properties = { tag = tags[1][6] } },
    { rule = { class = "hubstaff" },
    properties = { tag = tags[1][6] } },
    { rule = { class = "Thunderbird" },
    properties = { tag = tags[1][5] } },
    { rule = { class = "Gitter" },
    properties = { tag = tags[1][7] } },
    { rule = { class = "Telegram" },
    properties = { tag = tags[1][7] } }
}
-- }}}
-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c, startup)
    -- Enable sloppy focus
    c:connect_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end

    local titlebars_enabled = false
    if titlebars_enabled and (c.type == "normal" or c.type == "dialog") then
        -- buttons for the titlebar
        local buttons = awful.util.table.join(
        awful.button({ }, 1, function()
            client.focus = c
            c:raise()
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            client.focus = c
            c:raise()
            awful.mouse.client.resize(c)
        end)
        )

        -- Widgets that are aligned to the left
        local left_layout = wibox.layout.fixed.horizontal()
        left_layout:add(awful.titlebar.widget.iconwidget(c))
        left_layout:buttons(buttons)

        -- Widgets that are aligned to the right
        local right_layout = wibox.layout.fixed.horizontal()
        right_layout:add(awful.titlebar.widget.floatingbutton(c))
        right_layout:add(awful.titlebar.widget.maximizedbutton(c))
        right_layout:add(awful.titlebar.widget.stickybutton(c))
        right_layout:add(awful.titlebar.widget.ontopbutton(c))
        right_layout:add(awful.titlebar.widget.closebutton(c))

        -- The title goes in the middle
        local middle_layout = wibox.layout.flex.horizontal()
        local title = awful.titlebar.widget.titlewidget(c)
        title:set_align("center")
        middle_layout:add(title)
        middle_layout:buttons(buttons)

        -- Now bring it all together
        local layout = wibox.layout.align.horizontal()
        layout:set_left(left_layout)
        layout:set_right(right_layout)
        layout:set_middle(middle_layout)

        awful.titlebar(c):set_widget(layout)
    end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}
-- Autostart {{{
function run_once(prg,arg_string,pname,screen)
    if not prg then
        do return nil end
    end

    if not pname then
        pname = prg
    end

    if not arg_string then
        awful.util.spawn_with_shell("pgrep -f -u $USER -x '" .. pname .. "' || (" .. prg .. ")",screen)
    else
        awful.util.spawn_with_shell("pgrep -f -u $USER -x '" .. pname .. " ".. arg_string .."' || (" .. prg .. " " .. arg_string .. ")",screen)
    end
end

run_once("xscreensaver --no-splash")
run_once("thunderbird", nil, nil)
run_once("nm-applet")
run_once("telegram")
run_once("gitter")
run_once("dropbox")
-- }}}
bashets.start()
-- vim:foldmethod=marker:foldlevel=0
