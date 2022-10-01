tool
class_name GameDefaultColors
extends Reference


var _COLOR_BACKGROUND := Color("453d30")
var _COLOR_BACKGROUND_LIGHTER := Color("574d3d")
var _COLOR_BACKGROUND_DARKER := Color("362f25")

var _COLOR_TEXT := Color("eeeeee")
var _COLOR_HEADER := Color("faca7d")
var _COLOR_FOCUS := Color("faca7d")

var _COLOR_BUTTON := Color("c27e10")
var _COLOR_BUTTON_LIGHTER := Color("eba534")
var _COLOR_BUTTON_DARKER := Color("734905")

var _COLOR_SHADOW := Color("88000000")

var _HUD_KEY_VALUE_BOX_MODULATE_COLOR := Color(0.1, 0.7, 1.2, 1.0)
var _BUTTON_PULSE_MODULATE_COLOR := Color(1.5, 1.5, 3.0, 1.0)

# Should match Project Settings > Rendering > Environment > Default Clear Color.
var background := _COLOR_BACKGROUND

var boot_splash_background := ColorFactory.palette("default_splash_background")
var text := _COLOR_TEXT
var header := _COLOR_HEADER
var focus_border := _COLOR_FOCUS
var link_normal := _COLOR_BUTTON_LIGHTER
var link_hover := _COLOR_BUTTON
var link_pressed := _COLOR_BUTTON_DARKER
var button_normal := _COLOR_BUTTON
var button_pulse_modulate := _BUTTON_PULSE_MODULATE_COLOR
var button_disabled := _COLOR_BUTTON_LIGHTER
var button_focused := _COLOR_BUTTON_LIGHTER
var button_hover := _COLOR_BUTTON_LIGHTER
var button_pressed := _COLOR_BUTTON_DARKER
var button_border := _COLOR_TEXT
var dropdown_normal := _COLOR_BACKGROUND
var dropdown_disabled := _COLOR_BACKGROUND_LIGHTER
var dropdown_focused := _COLOR_BACKGROUND_LIGHTER
var dropdown_hover := _COLOR_BACKGROUND_LIGHTER
var dropdown_pressed := _COLOR_BACKGROUND_DARKER
var dropdown_border := _COLOR_BACKGROUND_DARKER
var tooltip := _COLOR_BACKGROUND
var tooltip_bg := _COLOR_TEXT
var popup_background := _COLOR_BACKGROUND_LIGHTER
var scroll_bar_background := _COLOR_BACKGROUND_LIGHTER
var scroll_bar_grabber_normal := _COLOR_BUTTON
var scroll_bar_grabber_hover := _COLOR_BUTTON_LIGHTER
var scroll_bar_grabber_pressed := _COLOR_BUTTON_DARKER
var slider_background := _COLOR_BACKGROUND_DARKER
var zebra_stripe_even_row := _COLOR_BACKGROUND_LIGHTER
var overlay_panel_background := _COLOR_BACKGROUND_DARKER
var overlay_panel_border := _COLOR_TEXT
var notification_panel_background := _COLOR_BACKGROUND_DARKER
var notification_panel_border := _COLOR_TEXT
var header_panel_background := _COLOR_BACKGROUND
var screen_border := _COLOR_TEXT
var shadow := _COLOR_SHADOW

# ----------------------

var highlight_light_green := Color("eaffdb")
var highlight_green := Color("85f23a")
var highlight_light_blue := Color("a8ecff")
var highlight_blue := Color("1cb0ff")
var highlight_dark_blue := Color("003066")
var highlight_disabled := Color("bb8b8b8b")
var highlight_yellow := Color("ccc016")
var highlight_orange := Color("cc7a16")
var highlight_red := Color("cc2c16")
var highlight_light_red := Color("ffd1bd")
var highlight_dark_red := Color("5e0017")
var highlight_light_purple := Color("f2e0ff")
var highlight_purple := Color("b04fff")
var highlight_dark_purple := Color("51048f")

#var highlight_pink := Color("ca4fff")
#var highlight_pink_new := Color("d94fff")
#var highlight_blue_selected := Color("667aff")
#var highlight_light_blue_selected := Color("d9deff")

var highlight_teal := Color("4fffc4")
var highlight_light_teal := Color("d4fff0")
var highlight_dark_teal := Color("005236")
var highlight_green_selected := Color("4fff7b")
var highlight_light_green_selected := Color("d4ffde")
var highlight_blue_selected := Color("39e1f7")
var highlight_light_blue_selected := Color("adf5ff")
#var highlight_green_idle_selected := Color("81ff4f")
#var highlight_green_new_selected := Color("9bff4f")
var highlight_yellow_idle_selected := Color("e5ff4f")
var highlight_yellow_new_selected := Color("f9ff85")

var highlight_purply_blue := Color("9f96ff")
var faint_orange := Color("ffdea6")

var cost := Color("fdff70")

var modulation_button_normal := highlight_teal
var modulation_button_hover := highlight_light_teal
var modulation_button_pressed := highlight_dark_teal
var modulation_button_disabled := highlight_disabled

var friendly_idle := ColorFactory.opacify("highlight_yellow_idle_selected", 0.6)
var friendly_active := ColorFactory.opacify("highlight_teal", 0.4)
var friendly_new := ColorFactory.opacify("highlight_yellow_new_selected", 0.9)
var friendly_selected := ColorFactory.opacify("highlight_blue_selected", 0.9)
var friendly_hovered := ColorFactory.opacify("highlight_light_blue_selected", 0.9)

var building_normal := ColorFactory.opacify("highlight_teal", 0.65)
var building_disconnected := ColorFactory.opacify("highlight_red", 0.9)
var building_selected := ColorFactory.opacify("highlight_blue_selected", 0.9)
var building_hovered := \
    ColorFactory.opacify("highlight_light_blue_selected", 0.9)

var hud_icon := highlight_purply_blue

var info_panel_header := highlight_purply_blue

var separator := ColorFactory.opacify("button_hover", 0.6)

var health_bar_background := Color("363552")
var health_bar_full := Color("27cc37")
var health_bar_medium := Color("dedb23")
var health_bar_empty := Color("ff0000")
var health_bar_heart := Color("ff5768")
