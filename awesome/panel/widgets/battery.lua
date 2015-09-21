local awful     = require("awful")
local wibox     = require("wibox")
local beautiful = require("beautiful")

return function(markup)
    space3 = markup.font("Liberation Mono 3", " ")
    batterywidget = wibox.widget.background()
    batterywidget:set_bgimage(beautiful.widget_display)
    percent = wibox.widget.textbox()
    percent:set_markup(space3 .. "Battery" .. markup.font("Liberation Mono 5", " "))
    remaining = wibox.widget.textbox()
    remaining:set_markup(space3 .. "Battery" .. markup.font("Liberation Mono 5", " "))
    batterywidget:set_widget(percent)
    batterywidgettimer = timer({ timeout = 5 })
    local index = 1
    local loop_widgets = { percent, remaining }
    batterywidgettimer:connect_signal("timeout",
    function()
        fh = assert(io.popen("acpi | cut -d, -f 2 -", "r"))
        local value = tonumber(string.match(fh:read("*l"), "%d+"))
        if value > 90 then
            widget_battery:set_image(beautiful.widget_battery_full)
        elseif value > 80 then
            widget_battery:set_image(beautiful.widget_battery_80)
        elseif value > 60 then
            widget_battery:set_image(beautiful.widget_battery_60)
        elseif value > 40 then
            widget_battery:set_image(beautiful.widget_battery_40)
        elseif value > 20 then
            widget_battery:set_image(beautiful.widget_battery_20)
        else
            widget_battery:set_image(beautiful.widget_battery_critical)
        end

        percent:set_markup(space3 .. tostring(value) .. "%" .. markup.font("Liberation Mono 5", " "))
        fh:close()
        fh = assert(io.popen("acpi | cut -d, -f 3 -", "r"))
        local value = fh:read("*l")
        if value == nil or value == '' then
            value = "Full"
        end
        remaining:set_markup(space3 .. value .. markup.font("Liberation Mono 5", " "))
        fh:close()
    end
    )
    batterywidgettimer:start()
    batterywidget:buttons(awful.util.table.join(awful.button({}, 1,
    function ()
        index = index % #loop_widgets + 1
        batterywidget:set_widget(loop_widgets[index])
    end)))
    return batterywidget
end
