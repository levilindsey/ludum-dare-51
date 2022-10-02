tool
class_name FiringRange
extends Area2D


const _RANGE_MULTIPLIER := 0.6
const _RANGE_TEST_ANGLE := PI / 4.0

export var entity_command_type := CommandType.UNKNOWN
export var upgrade_type := UpgradeType.UNKNOWN

var firing_range: FiringRange


func set_up() -> void:
    _define_extents()
    _define_collision_mask()


func _define_extents() -> void:
    var projectile_type := \
        Projectile.get_projectile_type_for_command_type(entity_command_type)
    
    var tower_upgrade_type := UpgradeType.UNKNOWN
    var start_speed := ProjectileSpeeds.get_speed(
        entity_command_type,
        upgrade_type,
        tower_upgrade_type)
    
    var cosA := cos(_RANGE_TEST_ANGLE)
    var sinA := sin(_RANGE_TEST_ANGLE)
    var extra_height := 0.0
    var extent_x := \
        start_speed * cosA / Su.movement.gravity_default * \
        (start_speed * sinA + sqrt(
            start_speed * start_speed * sinA * sinA + \
            2.0 * Su.movement.gravity_default * extra_height))
    extent_x *= _RANGE_MULTIPLIER
    
    $CollisionShape2D.shape.extents.x = extent_x
    $CollisionShape2D.shape.extents.y = extent_x


func _define_collision_mask() -> void:
    var is_friendly := \
        entity_command_type == CommandType.HERO or \
        entity_command_type == CommandType.SMALL_WORKER or \
        entity_command_type == CommandType.MEDIUM_WORKER or \
        entity_command_type == CommandType.LARGE_WORKER or \
        entity_command_type == CommandType.SMALL_TOWER or \
        entity_command_type == CommandType.MEDIUM_TOWER or \
        entity_command_type == CommandType.LARGE_TOWER
    
    var mask_layer_names: Array
    if is_friendly:
        mask_layer_names = [
            "enemies",
            "enemy_buildings",
        ]
    else:
        mask_layer_names = [
            "friendlies",
            "friendly_buildings",
        ]
    
    for mask_layer_name in mask_layer_names:
        var layer_bit_mask: int = \
            Sc.utils.get_physics_layer_bitmask_from_name(mask_layer_name)
        self.collision_mask |= layer_bit_mask
