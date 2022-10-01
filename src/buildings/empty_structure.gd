tool
class_name EmptyStructure
extends Building


const ENTITY_COMMAND_TYPE := CommandType.BUILDING_EMPTY


func _init().(ENTITY_COMMAND_TYPE) -> void:
    pass


func _ready() -> void:
    Sc.slow_motion.set_time_scale_for_node($ShaderOutlineableAnimatedSprite)


func _get_radial_menu_item_types() -> Array:
    return [
        CommandType.BUILDING_TOWER,
        CommandType.BUILDING_FARM,
        CommandType.BUILDING_INFO,
    ]


func _update_outline() -> void:
    $ShaderOutlineableAnimatedSprite.is_outlined = \
            active_outline_alpha_multiplier > 0.0
    $ShaderOutlineableAnimatedSprite.outline_color = outline_color
    $ShaderOutlineableAnimatedSprite.outline_color.a *= \
            active_outline_alpha_multiplier
