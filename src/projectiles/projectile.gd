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
