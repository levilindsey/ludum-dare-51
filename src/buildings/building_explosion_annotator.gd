class_name BuildingExplosionAnnotator
extends TransientAnnotator


const BUILDING_EXPLOSION_SCENE := \
    preload("res://src/buildings/building_explosion.tscn")

const DURATION := 1.0

var explosion: BuildingExplosion


func _init(position: Vector2).(DURATION) -> void:
    explosion = Sc.utils.add_scene(self, BUILDING_EXPLOSION_SCENE)
    explosion.position = position
    
    _update()
