tool
class_name EmptyStructure
extends Building


const ENTITY_COMMAND_TYPE := CommandType.BUILDING_EMPTY


func _init().(ENTITY_COMMAND_TYPE) -> void:
    pass


func _build_structure(button_type: int) -> void:
    Sc.level.add_command(button_type, self)


func _get_normal_highlight_color() -> Color:
    return ColorConfig.TRANSPARENT


func _ready() -> void:
    Sc.slow_motion.set_time_scale_for_node($ShaderOutlineableAnimatedSprite)


func _get_radial_menu_item_types() -> Array:
    return [
#        CommandType.SMALL_TOWER,
#        CommandType.SMALL_FARM,
        CommandType.BUILDING_INFO,
    ]


func _on_hit_by_projectile(projectile) -> void:
    ._on_hit_by_projectile(projectile)
    assert(false, "EmptyBuilding should not trigger projectile collisions.")


func _update_outline() -> void:
    $ShaderOutlineableAnimatedSprite.is_outlined = \
        active_outline_alpha_multiplier > 0.0
    $ShaderOutlineableAnimatedSprite.outline_color = outline_color
    $ShaderOutlineableAnimatedSprite.outline_color.a *= \
        active_outline_alpha_multiplier
