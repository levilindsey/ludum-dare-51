class_name Command
extends Reference


var type := CommandType.UNKNOWN

# FIXME: ------------
#var target_building: Building
#var next_target_building: Building
var target_building
var next_target_building

var destination: PositionAlongSurface

var worker

var meta

var is_navigating := false


func _init(
        type: int,
        # FIXME: ---------------
#        target_building: Building,
#        next_target_building: Building = null,
        target_building,
        next_target_building = null,
        destination: PositionAlongSurface = null,
        meta = null) -> void:
    assert(target_building == null or target_building != next_target_building)
    self.type = type
    self.target_building = target_building
    self.next_target_building = next_target_building
    self.destination = destination
    self.meta = meta


func get_depends_on_target_building() -> bool:
    return type == CommandType.BUILDING_BASE_SMALL_UPGRADE or \
        type == CommandType.BUILDING_BASE_MEDIUM_UPGRADE or \
        type == CommandType.BUILDING_TOWER_SMALL_UPGRADE or \
        type == CommandType.BUILDING_TOWER_MEDIUM_UPGRADE or \
        type == CommandType.BUILDING_FARM_SMALL_UPGRADE or \
        type == CommandType.BUILDING_FARM_MEDIUM_UPGRADE or \
        type == CommandType.BUILDING_OCCUPY or \
        type == CommandType.BUILDING_VACATE or \
        type == CommandType.BUILDING_RECYCLE


func get_position() -> Vector2:
    return destination.target_point if \
        is_instance_valid(destination) else \
        target_building.position if \
        is_instance_valid(target_building) else \
        Vector2.INF
