class_name LevelSession
extends SurfacerLevelSession
# NOTE: Don't store references to nodes that should be destroyed with the
#       level, because this session-state will persist after the level is
#       destroyed.


var worker_count := 0
var enemy_count := 0
var building_count := 0

var current_enemy_spawn_point_count := 0
var total_enemy_spawn_point_count := 0

var worker_capacity := 10

var total_money := 0
var current_money := 0

var workers_built_count := 0
var enemies_built_count := 0
var buildings_built_count := 0

var projectiles_built_count := 0
var projectiles_collided_count := 0

var wave_count := 0


func reset(id: String) -> void:
    .reset(id)
    
    if Engine.editor_hint:
        return
    
    worker_count = 0
    enemy_count = 0
    building_count = 0
    
    current_enemy_spawn_point_count = 0
    total_enemy_spawn_point_count = 0
    
    worker_capacity = 10
    
    total_money = 0
    current_money = 0
    
    workers_built_count = 0
    enemies_built_count = 0
    buildings_built_count = 0
    
    projectiles_built_count = 0
    projectiles_collided_count = 0
    
    wave_count = 0
