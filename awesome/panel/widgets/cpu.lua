local beautiful     = require("beautiful")
local wibox         = require("wibox")
local lain          = require("lain")

return function (markup)
    space3 = markup.font("Liberation Mono 3", " ")
    cpu_widget = lain.widgets.cpu({
        settings = function()
            local value = tonumber(cpu_now.usage)
            local format = ""
            if value < 10 then
                format = "  " .. tostring(value)
            elseif value < 100 then
                format = " " .. tostring(value)
            else
                format = tostring(value)
            end
            widget:set_markup(space3 .. format .. "%" .. markup.font("Liberation Mono 5", " "))
        end
    })

    cpuwidget = wibox.widget.background()
    cpuwidget:set_widget(cpu_widget)
    cpuwidget:set_bgimage(beautiful.widget_display)
    return cpuwidget
end
