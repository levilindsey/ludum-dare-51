tool
class_name Hero
extends Friendly


const ENTITY_COMMAND_TYPE := CommandType.HERO


func _init().(ENTITY_COMMAND_TYPE) -> void:
    pass


func _ready() -> void:
    is_initial_nav = false
    is_new = false


func _on_health_depleted() -> void:
    # FIXME: ------------------------- Game over!
    pass


func _process_sounds() -> void:
    if just_triggered_jump:
        Sc.audio.play_sound("test_character_jump")
    
    if surface_state.just_left_air:
        Sc.audio.play_sound("test_character_land")
    elif surface_state.just_touched_surface:
        Sc.audio.play_sound("test_character_hit_surface")
