tool
class_name SmallBase
extends Base


const ENTITY_COMMAND_TYPE := CommandType.SMALL_BASE


func _init().(ENTITY_COMMAND_TYPE) -> void:
    pass


func _ready() -> void:
    Sc.slow_motion.set_time_scale_for_node($ShaderOutlineableAnimatedSprite)


func _build_structure(button_type: int) -> void:
    Sc.logger.error("Abstract Building._build_structure is not implemented")


func _get_radial_menu_item_types() -> Array:
    return [
        CommandType.FRIENDLY_RALLY,
        CommandType.BUILDING_BASE_SMALL_UPGRADE,
        CommandType.BUILDING_INFO,
    ]


func _update_outline() -> void:
    $ShaderOutlineableAnimatedSprite.is_outlined = \
            active_outline_alpha_multiplier > 0.0
    $ShaderOutlineableAnimatedSprite.outline_color = outline_color
    $ShaderOutlineableAnimatedSprite.outline_color.a *= \
            active_outline_alpha_multiplier
