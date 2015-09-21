
                -- [    Pro Medium Light theme for Awesome 3.5.5    ] --
                -- [                 author: barwinco               ] --
                -- [         http://github.com/barwinco/pro         ] --

-- // got the idea from Holo theme by Luke Bonham (https://github.com/copycat-killer)

-- patch for taglist: https://github.com/awesomeWM/awesome/pull/39


theme                   = {}
theme.icons             = os.getenv("HOME") .. "/.config/awesome/theme/icons/"
theme.wallpapers        = "/home/mkusher/Pictures/wallpapers/curent/desktop/"
theme.font              = "Ubuntu 14"

theme.fg_normal         = "#ffffff"
theme.fg_focus          = "#ffffff"
theme.fg_urgent         = "#ffffff"

theme.bg_normal         = "#3f3f4c"
theme.bg_focus          = "#525263"
theme.bg_urgent         = "#3F3F3F"
theme.bg_systray        = "#3f3f4c"

theme.clockgf           = "#eeeeee"

--theme.panel      = "png:" .. theme.icons .. "/panel/panel.png"
theme.panel             = theme.bg_normal

-- | Borders | --

theme.border_width      = 0
theme.border_normal     = "#000000"
theme.border_focus      = "#000000"
theme.border_marked     = "#000000"

-- | Menu | --

theme.menu_height       = 32
theme.menu_width        = 160

-- | Layout | --

theme.layout_floating   = theme.icons .. "/panel/layouts/floating.png"
theme.layout_tile       = theme.icons .. "/panel/layouts/tile.png"
theme.layout_tileleft   = theme.icons .. "/panel/layouts/tileleft.png"
theme.layout_tilebottom = theme.icons .. "/panel/layouts/tilebottom.png"
theme.layout_tiletop    = theme.icons .. "/panel/layouts/tiletop.png"

-- | Taglist | --

theme.taglist_bg_empty      = theme.bg_focus
theme.taglist_bg_occupied   = theme.bg_focus
theme.taglist_bg_urgent     = theme.bg_focus
--theme.taglist_bg_occupied = "png:" .. theme.icons .. "/panel/taglist/occupied.png"
--theme.taglist_bg_urgent   = "png:" .. theme.icons .. "/panel/taglist/urgent.png"
theme.taglist_bg_focus      = "#90a366"
theme.taglist_fb_occupied   = "#cccccc"
theme.taglist_fb_urgent   = "#cccccc"
theme.taglist_font          = "Liberation Sans 15"

-- | Tasklist | --

theme.tasklist_font                 = "Liberation Serif 15"
theme.tasklist_disable_icon         = false
theme.tasklist_bg_normal            = "png:" .. theme.icons .. "panel/tasklist/normal.png"
theme.tasklist_bg_focus             = "png:" .. theme.icons .. "panel/tasklist/focus.png"
theme.tasklist_bg_urgent            = "png:" .. theme.icons .. "panel/tasklist/urgent.png"
theme.tasklist_fg_focus             = theme.fg_focus
theme.tasklist_fg_urgent            = theme.fg_urgent
theme.tasklist_fg_normal            = theme.fg_normal
theme.tasklist_floating             = ""
theme.tasklist_sticky               = ""
theme.tasklist_ontop                = ""
theme.tasklist_maximized_horizontal = ""
theme.tasklist_maximized_vertical   = ""

theme.widget_hubstaff               = theme.icons .. "/panel/widgets/widget_hubstaff.png"
-- | Clock / Calendar | --

theme.widget_clock = theme.icons .. "/panel/widgets/widget_clock.png"
theme.widget_cal   = theme.icons .. "/panel/widgets/widget_cal.png"

-- theme.widget_tmp = theme.icons .. "/panel/widgets/widget_tmp.png"
theme.widget_battery_full    = theme.icons .. "/panel/widgets/battery/full.png"
theme.widget_battery_80    = theme.icons .. "/panel/widgets/battery/80.png"
theme.widget_battery_60    = theme.icons .. "/panel/widgets/battery/60.png"
theme.widget_battery_40    = theme.icons .. "/panel/widgets/battery/40.png"
theme.widget_battery_20    = theme.icons .. "/panel/widgets/battery/20.png"
theme.widget_battery_critical    = theme.icons .. "/panel/widgets/battery/critical.png"

-- | Misc | --

theme.menu_submenu_icon = theme.icons .. "submenu.png"

return theme

