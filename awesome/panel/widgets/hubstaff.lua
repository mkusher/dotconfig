local awful         = require("awful")
local wibox         = require("wibox")
local beautiful     = require("beautiful")
local asyncshell    = require("asyncshell")
local naughty       = require("naughty")
local value = "0:00:00"
local isEnabled = false
local time_incrementer = timer({ timeout = 1 })

function set_widget_text(widget, value)
    widget:set_markup(space3 .. value .. markup.font("Liberation Mono 5", " "))
end
function sync_time(widget)
    asyncshell.request("python3 /home/mkusher/.bin/hubstaff.py", function(output)
        pcall(function()
            local fh = assert(output)
            value = fh:read("*l")
            if isEnabled then
                naughty.notify({
                    preset = naughty.config.presets.low,
                    title = "Hubstaff time",
                    text = value
                })
            end
            inc_time(widget)
            fh:close()
        end)
    end
    )
end

function enableHubstaff()
    isEnabled = true
    time_incrementer:start()
end

function disableHubstaff()
    isEnabled = false
    time_incrementer:stop()
end

function inc_time(widget)
    local fh = assert(io.popen("python /home/mkusher/.bin/hubstaff_incrementer.py \"" .. value .. "\""))
    value = fh:read("*l")
    set_widget_text(widget, value)
end

return function(markup)
    local widget = wibox.widget.textbox()
    set_widget_text(widget, value)
    local widget_wrapper = wibox.widget.background()
    widget_wrapper:set_bgimage(beautiful.widget_display)
    widget_wrapper:set_widget(widget)
    local time_syncer = timer({ timeout = 300 })
    time_syncer:connect_signal("timeout",
    function()
        sync_time(widget)
    end
    )
    sync_time(widget)
    time_incrementer:connect_signal("timeout",
    function()
        inc_time(widget)
    end
    )
    time_syncer:start()
    return widget_wrapper
end
