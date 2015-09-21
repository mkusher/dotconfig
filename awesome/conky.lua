local awful = require("awful")
function get_conky()
    local clients = client.get()
    local conky = {}
    local i = 1
    local j = 1
    while clients[i]
    do
        if clients[i].class == "Conky"
        then
            conky[j] = clients[i]
            j = j + 1
        end
        i = i + 1
    end
    return conky
end
function raise_conky()
    local conky = get_conky()
    local i = 1
    while conky[i]
    do
        conky[i].ontop = true
        i = i + 1
    end
end
function lower_conky()
    local conky = get_conky()
    local i = 1
    while conky[i]
    do
        conky[i].ontop = false
        i = i + 1
    end
end
function toggle_conky()
    local conky = get_conky()
    local i = 1
    while conky[i]
    do
        conky[i].ontop = not conky[i].ontop
        i = i + 1
    end
end
function start_conky()
    awful.util.spawn_with_shell("pkill -KILL conky")
    local clients = client.get()
    local i = 0
    for i=1, #clients
    do
        pcall(function()
            clients[i]:raise()
            clients[i].ontop = true
            clients[i].focus = true
        end)
    end
    awful.util.spawn_with_shell("/home/mkusher/.Conky/mstyle.sh")
end
