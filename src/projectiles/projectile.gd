tool
class_name Projectile
extends Node2D


enum {
    UNKNOWN,
    FRIENDLY,
    SMALL_ENEMY,
    LARGE_ENEMY,
}


export var projectile_type := UNKNOWN

var entity_command_type := UNKNOWN

var tower_multiplier := 1.0

var unit_upgrade_multiplier := 1.0

var damage: int setget ,_get_damage

var velocity := Vector2.INF


func _destroy() -> void:
    queue_free()


func _get_damage_for_projectile_type() -> float:
    match projectile_type:
        FRIENDLY:
            return 40.0
        SMALL_ENEMY:
            return 30.0
        LARGE_ENEMY:
            return 30.0 * 3.0
        _:
            Sc.logger.error("Projectile._get_damage_for_projectile_type")
            return INF


func _get_damage() -> int:
    var base_upgrade_multiplier: float = \
        Sc.level.session.get_damage_multiplier() if \
        projectile_type == FRIENDLY else \
        1.0
    return int(
        _get_damage_for_projectile_type() *
        tower_multiplier *
        unit_upgrade_multiplier * 
        base_upgrade_multiplier)


static func get_projectile_type_for_command_type(command_type: int) -> int:
    match command_type:
        CommandType.HERO, \
        CommandType.SMALL_WORKER, \
        CommandType.MEDIUM_WORKER, \
        CommandType.LARGE_WORKER:
            return FRIENDLY
        CommandType.ENEMY_SMALL:
            return SMALL_ENEMY
        CommandType.ENEMY_LARGE:
            return LARGE_ENEMY
        _:
            Sc.logger.error("Projectile.get_projectile_type_for_command_type")
            return UNKNOWN


func update_rotation_for_velocity() -> void:
    if projectile_type != FRIENDLY:
        return
    $TextureOutlineableSprite.rotation = velocity.angle()


func _on_Area2D_area_entered(area) -> void:
    assert(area.has_method("get_entity_type"))
    _on_collided(area, area.entity_command_type)


func _on_Area2D_body_entered(body) -> void:
    assert(body.has_method("get_entity_type"))
    _on_collided(body, body.entity_command_type)


func _on_collided(
        target,
        target_type: int) -> void:
    match target_type:
        CommandType.BUILDING_EMPTY:
            # Do nothing.
            pass
        CommandType.HERO, \
        CommandType.SMALL_WORKER, \
        CommandType.MEDIUM_WORKER, \
        CommandType.LARGE_WORKER, \
        CommandType.ENEMY_SMALL, \
        CommandType.ENEMY_LARGE:
            target._on_hit_by_projectile(self)
            Sc.level.remove_projectile(self)
        CommandType.BUILDING_ENEMY_SPAWN, \
        CommandType.SMALL_BASE, \
        CommandType.MEDIUM_BASE, \
        CommandType.LARGE_BASE, \
        CommandType.SMALL_TOWER, \
        CommandType.MEDIUM_TOWER, \
        CommandType.LARGE_TOWER, \
        CommandType.SMALL_FARM, \
        CommandType.MEDIUM_FARM, \
        CommandType.LARGE_FARM:
            target._on_hit_by_projectile(self)
            Sc.level.remove_projectile(self)
        _:
            Sc.logger.error("Projectile._on_collided: %s" % str(target_type))
