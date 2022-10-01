tool
class_name Hud
extends SurfacerHud


const COOLDOWN_INDICATOR_SCENE := \
    preload("res://src/gui/cooldown_indicator.tscn")

var cooldown_indicator: CooldownIndicator


func set_up() -> void:
    cooldown_indicator = Sc.utils.add_scene(self, COOLDOWN_INDICATOR_SCENE)


func _destroy() -> void:
    ._destroy()
    cooldown_indicator._destroy()
