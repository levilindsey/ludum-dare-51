class_name BuildingExplosion
extends Node2D


func _ready() -> void:
    $AnimatedSprite.play()


func _on_AnimatedSprite_animation_finished() -> void:
    $AnimatedSprite.stop()
    $AnimatedSprite.frame = 56
