local beautiful     = require("beautiful")
local wibox         = require("wibox")
local lain          = require("lain")

return function (markup)
    space3 = markup.font("Liberation Mono 3", " ")
    mem_widget = lain.widgets.mem({
        settings = function()
            widget:set_markup(space3 .. mem_now.used .. "MB" .. markup.font("Lieration Mono", " "))
        end
    })

    memwidget = wibox.widget.background()
    memwidget:set_widget(mem_widget)
    memwidget:set_bgimage(beautiful.widget_display)
    return memwidget
end
