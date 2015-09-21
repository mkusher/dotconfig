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
local hubstaff      = require("panel.widgets.hubstaff")
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

local taglist_separator_text = wibox.widget.textbox()
taglist_separator_text:set_markup("<span color='" .. beautiful.bg_focus .. "'> </span>")
taglist_separator_text:set_font("Liberation Mono 25")
local taglist_separator = wibox.widget.background()
taglist_separator:set_widget(taglist_separator_text)

local taglist_space = wibox.widget.textbox()
taglist_space:set_text(" ")

local tasklist_separator_text = wibox.widget.textbox()
tasklist_separator_text:set_markup("<span color='" .. beautiful.bg_normal .. "'> </span>")
tasklist_separator_text:set_font("Liberation Mono 25")
local tasklist_separator = wibox.widget.background()
tasklist_separator:set_widget(tasklist_separator_text)
tasklist_separator:set_bg(beautiful.bg_focus)

local systray_separator_text = wibox.widget.textbox()
systray_separator_text:set_markup("<span color='" .. beautiful.bg_focus .. "'></span>")
systray_separator_text:set_font("Liberation Mono 25")
local systray_separator = wibox.widget.background()
systray_separator:set_widget(systray_separator_text)

local widget_separator = systray_separator

-- }}}
-- Widgets {{{
widget_clock = wibox.widget.imagebox()
widget_clock:set_image(beautiful.widget_clock)
widget_battery = wibox.widget.imagebox()
widget_battery:set_image(beautiful.widget_battery_full)
hubstaff_icon = wibox.widget.imagebox()
hubstaff_icon:set_image(beautiful.widget_hubstaff)

clockwidget = clock(markup)
batterywidget = battery(markup)
hubstaffwidget = hubstaff(markup)
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

    mywibox[s] = awful.wibox({ position = "top", screen = s, height = "32" })

    local left_layout = wibox.layout.fixed.horizontal()
    left_layout:add(taglist_space)
    left_layout:add(mytaglist[s])
    left_layout:add(taglist_separator)

    local right_layout = wibox.layout.fixed.horizontal()
    right_layout:add(tasklist_separator)
    if s == 1 then
        right_layout:add(mypromptbox[s])
        right_layout:add(wibox.widget.systray())
        right_layout:add(systray_separator)
    end


    right_layout:add(widget_battery)
    right_layout:add(batterywidget)
    right_layout:add(widget_separator)

    right_layout:add(hubstaff_icon)
    right_layout:add(hubstaffwidget)
    right_layout:add(widget_separator)

    right_layout:add(widget_clock)
    right_layout:add(clockwidget)

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
