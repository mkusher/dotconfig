local awful         = require("awful")
local wibox         = require("wibox")
local beautiful     = require("beautiful")
local asyncshell    = require("asyncshell")

function update_time(widget)
    asyncshell.request("python3 /home/mkusher/public_html/hubstaff.py", function(output)
        local fh = assert(output)
        local value = fh:read("*l")
        pcall(function()
            widget:set_markup(space3 .. value .. markup.font("Liberation Mono 5", " "))
        end)
        fh:close()
    end
    )
end

return function(markup)
    local widget = wibox.widget.textbox()
    widget:set_markup(space3 .. "Hubstaff" .. markup.font("Liberation Mono 5", " "))
    local widget_wrapper = wibox.widget.background()
    widget_wrapper:set_bgimage(beautiful.widget_display)
    widget_wrapper:set_widget(widget)
    local ticker = timer({ timeout = 120 })
    ticker:connect_signal("timeout",
    function()
        update_time(widget)
    end
    )
    update_time(widget)
    ticker:start()
    return widget_wrapper
end
