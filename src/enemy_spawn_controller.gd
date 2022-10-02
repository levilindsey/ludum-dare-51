class_name EnemySpawnController
extends Node2D


var previous_cooldown_count := 0

var _ENEMY_TIERS := [
    [CommandType.ENEMY_SMALL, UpgradeType.MINOR],
    [CommandType.ENEMY_SMALL, UpgradeType.MODERATE],
    [CommandType.ENEMY_LARGE, UpgradeType.MINOR],
    [CommandType.ENEMY_SMALL, UpgradeType.MAJOR],
    [CommandType.ENEMY_LARGE, UpgradeType.MODERATE],
    [CommandType.ENEMY_LARGE, UpgradeType.MAJOR],
]

var _MAX_TIER: int = pow(2, _ENEMY_TIERS.size() - 1)


func _physics_process(_delta: float) -> void:
    if Engine.editor_hint:
        return
    
    if Game.cooldown_count != previous_cooldown_count:
        previous_cooldown_count = Game.cooldown_count
        trigger_spawn()
        Sc.level.session.wave_count += 1


func trigger_spawn() -> void:
    var spawn_point_index := \
        int(randf() * 0.99999 * Sc.level.enemy_spawn_points.size())
    var spawn_point: EnemySpawn = \
        Sc.level.enemy_spawn_points[spawn_point_index]
    var spawn_position := spawn_point.get_center()
    
    var remaining_tiers := Game.cooldown_count
    var current_tier := remaining_tiers % _MAX_TIER
    spawn_tier(current_tier, spawn_position)
    
    while remaining_tiers > _MAX_TIER:
        remaining_tiers -= _MAX_TIER
        current_tier = remaining_tiers % _MAX_TIER
        spawn_tier(current_tier, spawn_position)


func spawn_tier(
        tier_number: int,
        spawn_position: Vector2) -> void:
    for i in range(_ENEMY_TIERS.size()):
        if tier_number & (1 << i) != 0:
            Sc.level.add_enemy(
                _ENEMY_TIERS[i][0],
                _ENEMY_TIERS[i][1],
                spawn_position)


func on_enemy_added(enemy: Enemy) -> void:
    pass


func on_enemy_removed(enemy: Enemy) -> void:
    pass
