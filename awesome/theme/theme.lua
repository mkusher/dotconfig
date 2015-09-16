
                -- [    Pro Medium Light theme for Awesome 3.5.5    ] --
                -- [                 author: barwinco               ] --
                -- [         http://github.com/barwinco/pro         ] --

-- // got the idea from Holo theme by Luke Bonham (https://github.com/copycat-killer)

-- patch for taglist: https://github.com/awesomeWM/awesome/pull/39


theme            = {}
theme.icons      = os.getenv("HOME") .. "/.config/awesome/theme/icons/"
theme.wallpaper  = "/home/mkusher/Pictures/wallpapers/curent/desktop/7SuF1NuuwUM.jpg"
theme.panel      = "png:" .. theme.icons .. "/panel/panel.png"
theme.font       = "Liberation Serif 14"

theme.fg_normal  = "#404040"
theme.fg_focus   = "#111111"
theme.fg_urgent  = "#CC9393"

theme.bg_normal  = "#B8B8B8"
theme.bg_focus   = "#eeeeee"
theme.bg_urgent  = "#3F3F3F"
theme.bg_systray = "#b8b8b8"

theme.clockgf    = "#eeeeee"

-- | Borders | --

theme.border_width  = 0
theme.border_normal = "#00000000"
theme.border_focus  = "#000000"
theme.border_marked = "#000000"

-- | Menu | --

theme.menu_height = 16
theme.menu_width  = 160

-- | Layout | --

theme.layout_floating   = theme.icons .. "/panel/layouts/floating.png"
theme.layout_tile       = theme.icons .. "/panel/layouts/tile.png"
theme.layout_tileleft   = theme.icons .. "/panel/layouts/tileleft.png"
theme.layout_tilebottom = theme.icons .. "/panel/layouts/tilebottom.png"
theme.layout_tiletop    = theme.icons .. "/panel/layouts/tiletop.png"

-- | Taglist | --

theme.taglist_bg_empty    = "png:" .. theme.icons .. "/panel/taglist/empty.png"
theme.taglist_bg_occupied = "png:" .. theme.icons .. "/panel/taglist/occupied.png"
theme.taglist_bg_urgent   = "png:" .. theme.icons .. "/panel/taglist/urgent.png"
theme.taglist_bg_focus    = "png:" .. theme.icons .. "/panel/taglist/focus.png"
theme.taglist_font        = "Terminus 11"

-- | Tasklist | --

theme.tasklist_font                 = "Liberation Serif Bold 15"
theme.tasklist_disable_icon         = false
theme.tasklist_bg_normal            = "png:" .. theme.icons .. "panel/tasklist/normal.png"
theme.tasklist_bg_focus             = "png:" .. theme.icons .. "panel/tasklist/focus.png"
theme.tasklist_bg_urgent            = "png:" .. theme.icons .. "panel/tasklist/urgent.png"
theme.tasklist_fg_focus             = "#505050"
theme.tasklist_fg_urgent            = "#505050"
theme.tasklist_fg_normal            = "#5a5a5a"
theme.tasklist_floating             = ""
theme.tasklist_sticky               = ""
theme.tasklist_ontop                = ""
theme.tasklist_maximized_horizontal = ""
theme.tasklist_maximized_vertical   = ""

-- | Widget | --

theme.widget_display   = theme.icons .. "/panel/widgets/display/widget_display.png"
theme.widget_display_r = theme.icons .. "/panel/widgets/display/widget_display_r.png"
theme.widget_display_c = theme.icons .. "/panel/widgets/display/widget_display_c.png"
theme.widget_display_l = theme.icons .. "/panel/widgets/display/widget_display_l.png"

-- | MPD | --

theme.mpd_prev  = theme.icons .. "/panel/widgets/mpd/mpd_prev.png"
theme.mpd_nex   = theme.icons .. "/panel/widgets/mpd/mpd_next.png"
theme.mpd_stop  = theme.icons .. "/panel/widgets/mpd/mpd_stop.png"
theme.mpd_pause = theme.icons .. "/panel/widgets/mpd/mpd_pause.png"
theme.mpd_play  = theme.icons .. "/panel/widgets/mpd/mpd_play.png"
theme.mpd_sepr  = theme.icons .. "/panel/widgets/mpd/mpd_sepr.png"
theme.mpd_sepl  = theme.icons .. "/panel/widgets/mpd/mpd_sepl.png"

-- | Separators | --

theme.spr    = theme.icons .. "/panel/separators/spr.png"
theme.sprtr  = theme.icons .. "/panel/separators/sprtr.png"
theme.spr4px = theme.icons .. "/panel/separators/spr4px.png"
theme.spr5px = theme.icons .. "/panel/separators/spr5px.png"

-- | Clock / Calendar | --

theme.widget_clock = theme.icons .. "/panel/widgets/widget_clock.png"
theme.widget_cal   = theme.icons .. "/panel/widgets/widget_cal.png"

-- | CPU / TMP | --

theme.widget_cpu            = theme.icons .. "/panel/widgets/widget_cpu.png"
-- theme.widget_tmp = theme.icons .. "/panel/widgets/widget_tmp.png"
theme.widget_battery_full    = theme.icons .. "/panel/widgets/widget_battery_full.png"
theme.widget_battery_90    = theme.icons .. "/panel/widgets/widget_battery_90.png"
theme.widget_battery_60    = theme.icons .. "/panel/widgets/widget_battery_60.png"
theme.widget_battery_40    = theme.icons .. "/panel/widgets/widget_battery_40.png"
theme.widget_battery_20    = theme.icons .. "/panel/widgets/widget_battery_20.png"
theme.widget_battery_10    = theme.icons .. "/panel/widgets/widget_battery_10.png"
theme.widget_battery_critical    = theme.icons .. "/panel/widgets/widget_battery_critical.png"


-- | MEM | --

theme.widget_mem = theme.icons .. "/panel/widgets/widget_mem.png"

-- | FS | --

theme.widget_fs     = theme.icons .. "/panel/widgets/widget_fs.png"
theme.widget_fs_hdd = theme.icons .. "/panel/widgets/widget_fs_hdd.png"

-- | Mail | --

theme.widget_mail = theme.icons .. "/panel/widgets/widget_mail.png"

-- | NET | --

theme.widget_netdl = theme.icons .. "/panel/widgets/widget_netdl.png"
theme.widget_netul = theme.icons .. "/panel/widgets/widget_netul.png"

-- | Misc | --

theme.menu_submenu_icon = theme.icons .. "submenu.png"

return theme

