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

var tower_multiplier := 1.0

var unit_upgrade_multiplier := 1.0

var damage: int setget ,_get_damage

var velocity := Vector2.INF


func _get_damage_for_projectile_type() -> float:
    match projectile_type:
        FRIENDLY:
            return 34.0
        SMALL_ENEMY:
            return 34.0
        LARGE_ENEMY:
            return 34.0 * 8.0
        _:
            Sc.logger.error("Projectile._get_damage_for_projectile_type")
            return INF


func _get_damage() -> int:
    return int(
        _get_damage_for_projectile_type() *
        tower_multiplier *
        unit_upgrade_multiplier)


func _on_collided_with_enemy(character) -> void:
    Sc.level.remove_projectile(self)


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
