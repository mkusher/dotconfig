local awful     = require("awful")
local wibox     = require("wibox")
local beautiful = require("beautiful")

-- | Clock / Calendar | --

return function(markup)
    space3 = markup.font("Liberation Mono 3", " ")
    clockgf = beautiful.clockgf

    mytextclock    = awful.widget.textclock(markup(clockgf, space3 .. "%I:%M %p" .. markup.font("Liberation Mono", " ")))
    mytextcalendar = awful.widget.textclock(markup(clockgf, space3 .. "%a %d %b"))

    clockwidget = wibox.widget.background()
    clockwidget:set_widget(mytextclock)
    clockwidget:set_bgimage(beautiful.widget_display)

    local index = 1
    local loop_widgets = { mytextclock, mytextcalendar }
    local loop_widgets_icons = { beautiful.widget_clock, beautiful.widget_cal }

    clockwidget:buttons(awful.util.table.join(awful.button({}, 1,
    function ()
        index = index % #loop_widgets + 1
        clockwidget:set_widget(loop_widgets[index])
        widget_clock:set_image(loop_widgets_icons[index])
    end)))
    return clockwidget
end
