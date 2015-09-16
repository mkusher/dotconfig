-- Modules {{{
local awful         = require("awful")
local vicious       = require("vicious")
local beautiful     = require("beautiful")
local wibox         = require("wibox")
local lain          = require("lain")
-- }}}
-- Widgets {{{
local clock         = require("panel.widgets.clock")
local cpu           = require("panel.widgets.cpu")
local mem           = require("panel.widgets.mem")
local battery       = require("panel.widgets.battery")
local mytasklist    = require("panel.task-list")
local mytaglist     = require("panel.tag-list")
-- }}}
-- Markup Init {{{
markup = lain.util.markup

space3 = markup.font("Terminus 3", " ")
space2 = markup.font("Terminus 2", " ")
vspace1 = '<span font="Terminus 3"> </span>'
vspace2 = '<span font="Terminus 3">  </span>'
clockgf = beautiful.clockgf
-- }}}
-- Panel inits {{{

spr = wibox.widget.imagebox()
spr:set_image(beautiful.spr)
spr4px = wibox.widget.imagebox()
spr4px:set_image(beautiful.spr4px)
spr5px = wibox.widget.imagebox()
spr5px:set_image(beautiful.spr5px)

widget_display = wibox.widget.imagebox()
widget_display:set_image(beautiful.widget_display)
widget_display_r = wibox.widget.imagebox()
widget_display_r:set_image(beautiful.widget_display_r)
widget_display_l = wibox.widget.imagebox()
widget_display_l:set_image(beautiful.widget_display_l)
widget_display_c = wibox.widget.imagebox()
widget_display_c:set_image(beautiful.widget_display_c)

-- }}}
-- Widgets {{{
widget_clock = wibox.widget.imagebox()
widget_clock:set_image(beautiful.widget_clock)
widget_battery = wibox.widget.imagebox()
widget_battery:set_image(beautiful.widget_battery_full)

clockwidget = clock(markup)
batterywidget = battery(markup)

widget_cpu = wibox.widget.imagebox()
widget_cpu:set_image(beautiful.widget_cpu)
cpuwidget = cpu(markup)

widget_mem = wibox.widget.imagebox()
widget_mem:set_image(beautiful.widget_mem)
memwidget = mem(markup)

-- }}}
-- PANEL {{{

mywibox           = {}
mypromptbox       = {}
mylayoutbox       = {}

for s = 1, screen.count() do

    mypromptbox[s] = awful.widget.prompt()

    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
    awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
    awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
    awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
    awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))

    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

    mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)

    mywibox[s] = awful.wibox({ position = "top", screen = s, height = "22" })

    local left_layout = wibox.layout.fixed.horizontal()
    left_layout:add(spr5px)
    left_layout:add(mytaglist[s])
    left_layout:add(spr5px)

    local right_layout = wibox.layout.fixed.horizontal()
    if s == 1 then
        right_layout:add(spr)
        right_layout:add(spr5px)
        right_layout:add(mypromptbox[s])
        right_layout:add(wibox.widget.systray())
        right_layout:add(spr5px)
    end

    right_layout:add(spr)

    right_layout:add(widget_battery)
    right_layout:add(widget_display_l)
    right_layout:add(batterywidget)
    right_layout:add(widget_display_r)
    right_layout:add(spr5px)

    right_layout:add(spr)

    right_layout:add(widget_cpu)
    right_layout:add(widget_display_l)
    right_layout:add(cpuwidget)
    right_layout:add(widget_display_r)
    right_layout:add(spr5px)

    right_layout:add(spr)

    right_layout:add(widget_mem)
    right_layout:add(widget_display_l)
    right_layout:add(memwidget)
    right_layout:add(widget_display_r)
    right_layout:add(spr5px)

    right_layout:add(spr)

    right_layout:add(widget_clock)
    right_layout:add(widget_display_l)
    right_layout:add(clockwidget)
    right_layout:add(widget_display_r)
    right_layout:add(spr5px)

    right_layout:add(spr)

    right_layout:add(mylayoutbox[s])

    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)
    layout:set_middle(mytasklist[s])
    layout:set_right(right_layout)

    mywibox[s]:set_bg(beautiful.panel)

    mywibox[s]:set_widget(layout)
end
-- }}}
-- vim:foldmethod=marker:foldlevel=0
