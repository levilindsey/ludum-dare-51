tool
class_name Hero
extends Friendly


func _ready() -> void:
    is_initial_nav = false
    is_new = false


func _on_health_depleted() -> void:
    # FIXME: ------------------------- Game over!
    pass


#func _on_started_colliding(
#        target: Node2D,
#        layer_names: Array) -> void:
#    match layer_names[0]:
#        "foo":
#            pass
#        _:
#            Sc.logger.error()


func _process_sounds() -> void:
    if just_triggered_jump:
        Sc.audio.play_sound("test_character_jump")
    
    if surface_state.just_left_air:
        Sc.audio.play_sound("test_character_land")
    elif surface_state.just_touched_surface:
        Sc.audio.play_sound("test_character_hit_surface")
