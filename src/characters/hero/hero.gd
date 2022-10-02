tool
class_name Hero
extends Friendly


const _FIRING_RANGE_SCENE := preload("res://src/firing_range.tscn")

const ENTITY_COMMAND_TYPE := CommandType.HERO

var upgrade_type := UpgradeType.MINOR

var firing_range: FiringRange

var shooting_target = null

var firing_targets := {}

var firing_interval := INF

var shot_start_time := -1.0


func _init().(ENTITY_COMMAND_TYPE) -> void:
    pass


func _ready() -> void:
    is_initial_nav = false
    is_new = false
    
    _set_up_firing_range()


func _set_up_firing_range() -> void:
    firing_range = Sc.utils.add_scene(self, _FIRING_RANGE_SCENE)
    firing_range.entity_command_type = entity_command_type
    firing_range.upgrade_type = upgrade_type
    firing_range.set_up()
    firing_range.connect("area_entered", self, "_on_area_entered_firing_range")
    firing_range.connect("body_entered", self, "_on_body_entered_firing_range")
    firing_range.connect("area_exited", self, "_on_area_exit_firing_range")
    firing_range.connect("body_exited", self, "_on_body_exit_firing_range")
    
    var projectile_type := \
        Projectile.get_projectile_type_for_command_type(entity_command_type)
    
    var tower_upgrade_type := UpgradeType.UNKNOWN
    firing_interval = ProjectileSpeeds.get_interval(
        entity_command_type,
        upgrade_type,
        tower_upgrade_type)

func _on_area_entered_firing_range(area) -> void:
    if _is_destroyed:
        return
    assert(area.has_method("get_entity_type"))
    firing_targets[area] = area
    _evaluate_shooting()

func _on_body_entered_firing_range(body) -> void:
    if _is_destroyed:
        return
    assert(body.has_method("get_entity_type"))
    firing_targets[body] = body
    _evaluate_shooting()

func _on_area_exit_firing_range(area) -> void:
    if _is_destroyed:
        return
    assert(area.has_method("get_entity_type"))
    firing_targets.erase(area)
    _evaluate_shooting()

func _on_body_exit_firing_range(body) -> void:
    if _is_destroyed:
        return
    assert(body.has_method("get_entity_type"))
    firing_targets.erase(body)
    _evaluate_shooting()

func _evaluate_shooting() -> void:
    for target in firing_targets.keys():
        if is_instance_valid(target):
            _handle_shooting(target)
            return
        else:
            firing_targets.erase(target)
    _handle_not_shooting()

func _handle_shooting(target) -> void:
    if shooting_target == target:
        return
    shooting_target = target
    shot_start_time = Game.scaled_play_time
    stop_on_surface()

func _handle_not_shooting() -> void:
    if !get_is_shooting():
        return
    shooting_target = null

func get_is_shooting() -> bool:
    return is_instance_valid(shooting_target)

func _update_shooting() -> void:
    if !get_is_shooting():
        return
    
    var shot_current_time := Game.scaled_play_time
    
    if did_move_last_frame:
        shot_start_time = shot_current_time
        return
    
    while shot_current_time - shot_start_time > firing_interval:
        shot_start_time += firing_interval
        
        var tower_upgrade_type := UpgradeType.UNKNOWN
        Sc.level.projectile_controller.shoot_at_target(
            entity_command_type,
            upgrade_type,
            tower_upgrade_type,
            shooting_target.position,
            get_projectile_launch_position())


func _physics_process(delta: float) -> void:
    if _is_destroyed:
        return
    if Engine.editor_hint:
        return
    
    _update_shooting()


func _on_health_depleted() -> void:
    Sc.level.on_hero_health_depleted(self)


func _process_sounds() -> void:
    if just_triggered_jump:
        Sc.audio.play_sound("test_character_jump")
    
    if surface_state.just_left_air:
        Sc.audio.play_sound("test_character_land")
    elif surface_state.just_touched_surface:
        Sc.audio.play_sound("test_character_hit_surface")


func _on_radial_menu_item_selected(item: RadialMenuItem) -> void:
    match item.id:
        CommandType.FRIENDLY_RALLY:
            Sc.level.rally(self.surface_state.last_position_along_surface)
        _:
            ._on_radial_menu_item_selected(item)


func _get_radial_menu_item_types() -> Array:
    return [
        CommandType.FRIENDLY_RALLY,
        CommandType.FRIENDLY_INFO,
    ]
