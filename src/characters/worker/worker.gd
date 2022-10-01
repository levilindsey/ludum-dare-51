tool
class_name Worker
extends Friendly


const ENTITY_COMMAND_TYPE := CommandType.SMALL_WORKER

var worker_type: int

var command: Command

var triggers_command_when_landed := false
var triggers_wander_when_landed := false

var _stationary_frames_count_with_command_active := 0


func _init().(ENTITY_COMMAND_TYPE) -> void:
    pass


func _ready() -> void:
    navigator.connect("navigation_started", self, "_on_navigation_started")
    navigator.connect("navigation_ended", self, "_on_navigation_ended")
    
    _walk_to_side_of_base()


func _walk_to_side_of_base() -> void:
    var target_point := Vector2(
        Sc.level.base.get_bounds().end.x,
        Sc.level.base.position.y)
    var surface: Surface = \
        Sc.level.base.get_position_along_surface(self).surface
    var destination := PositionAlongSurfaceFactory \
        .create_position_offset_from_target_point(
            target_point, surface, collider, true)
    start_command(Command.new(CommandType.FRIENDLY_MOVE, null, null, destination))
    is_initial_nav = true


func _physics_process(delta: float) -> void:
    if Engine.editor_hint:
        return
    
    if did_move_last_frame or \
            !is_instance_valid(command):
        _stationary_frames_count_with_command_active = 0
    else:
        _stationary_frames_count_with_command_active += 1
    
    # This is a hacky check to reset workers back to stable state in case
    # something goes wrong when changing commands, navigation, and idleness.
    if _stationary_frames_count_with_command_active > 7:
        Sc.logger.warning(
            "Worker._physics_process: " +
            "stationary_frames_count > 7, " +
            "with command still active.")
        clear_command_state()
        Sc.level.on_worker_idleness_changed(self)


func start_command(
        command: Command,
        triggers_navigation := true) -> void:
    var was_active := get_is_active()
    
    if is_instance_valid(self.command):
        Sc.level.cancel_command(self.command, true)
    
    self.command = command
    
    command.worker = self
    
    Sc.level.command_queue.erase(command)
    Sc.level.in_progress_commands[command] = true
    Sc.gui.hud.command_queue_list.sync_queue()
    
    if !was_active and !is_initial_nav:
        Sc.level.on_worker_idleness_changed(self)
    
    if !is_initial_nav:
        Sc.audio.play_sound("command_acc")
        is_new = false
    is_initial_nav = false
    
    _update_status()
    
    # If on the ground, start the command; otherwise, wait.
    stop_on_surface(false)


func open_radial_menu() -> void:
    .open_radial_menu()
    
    var static_behavior := get_behavior(StaticBehavior)
    default_behavior = static_behavior
    behavior.next_behavior = get_behavior(StaticBehavior)
    if !(behavior is PlayerNavigationBehavior) and \
            !(behavior is NavigationOverrideBehavior) and \
            !(behavior is StaticBehavior):
        clear_command_state()
        stop_on_surface(false)
        get_behavior(StaticBehavior).is_active = true


func _on_reached_building_to_build() -> void:
    # FIXME: Play sound and particles
    Sc.audio.play_sound("command_finished")
    assert(is_instance_valid(command) and \
            is_instance_valid(command.target_building))
    Sc.logger.print(
        "Worker._on_reached_building_to_build: worker=%s, building=%s, p=%s" % [
            self.character_name,
            CommandType.get_string(command.target_building.entity_command_type),
            command.target_building.position,
        ])
    Sc.level.deduct_energy(CommandType.COSTS[command.type])
    Sc.level.replace_building(command.target_building, command.type)


func _on_reached_building_to_destroy() -> void:
    if !is_instance_valid(command) or \
            !is_instance_valid(command.target_building):
        # The building has been destroyed.
        # FIXME: Play error sound
        Sc.audio.play_sound("nav_select_fail")
        return
    
    # FIXME: Play sound and particles
    Sc.audio.play_sound("command_finished")
    Sc.logger.print(
        "Worker._on_reached_building_to_destroy: worker=%s, building=%s, p=%s" % [
            self.character_name,
            CommandType.get_string(command.target_building.entity_command_type),
            command.target_building.position,
        ])
    assert(is_instance_valid(command.target_building))
    Sc.level.replace_building(command.target_building, CommandType.BUILDING_EMPTY)
    Sc.level.deduct_energy(Cost.BUILDING_RECYCLE)


func _navigate_command(building = null) -> void:
    assert(is_instance_valid(command))
    
    command.is_navigating = true
    
    if !is_instance_valid(building):
        if is_instance_valid(command.destination):
            navigate_imperatively(command.destination)
            return
        else:
            building = command.target_building
    
    var already_there := \
        _extra_collision_detection_area.overlaps_area(building)
    if already_there:
        _on_navigation_ended()
    else:
        var destination: PositionAlongSurface = \
            building.get_position_along_surface(self)
        navigate_imperatively(destination)


func stop_on_surface(triggers_wander := false) -> void:
    triggers_wander_when_landed = \
        !is_instance_valid(command) and triggers_wander
    .stop_on_surface()


func _stop_nav_immediately() -> void:
    ._stop_nav_immediately()
    if is_instance_valid(command):
        _navigate_command()
    else:
        if triggers_wander_when_landed:
            default_behavior = get_behavior(WanderBehavior)
        if behavior is PlayerNavigationBehavior or \
                behavior is NavigationOverrideBehavior or \
                behavior is StaticBehavior:
            default_behavior.trigger(false)


func clear_command_state() -> void:
    _update_status()
    # FIXME: --------------------------------------------
    # - Maybe keep the worker selected?
    # - Maybe don't wander if selected, but then start wander when deselected?
    set_is_selected(false)
    if is_instance_valid(command):
        Sc.level.cancel_command(command, true)
        command = null
        Sc.level.on_worker_idleness_changed(self)


func _on_navigation_started(
        is_retry: bool,
        triggered_by_player: bool) -> void:
    set_is_selected(false)


func _on_navigation_ended(
        did_reach_destination := true,
        triggered_by_player := false) -> void:
    if !get_is_active() or \
            !command.is_navigating:
        return
    
    var stops: bool
    match command.type:
        CommandType.BUILDING_OCCUPY:
            # FIXME: -----------------------
            stops = true
        CommandType.BUILDING_VACATE:
            # FIXME: -----------------------
            stops = true
        CommandType.BUILDING_RECYCLE:
            _on_reached_building_to_destroy()
            stops = true
        CommandType.FRIENDLY_MOVE:
            stops = true
        CommandType.FRIENDLY_STOP:
            stops = true
        CommandType.FRIENDLY_RALLY:
            # FIXME: -----------------------
            stops = true
        CommandType.FRIENDLY_SMALL_UPGRADE, \
        CommandType.FRIENDLY_MEDIUM_UPGRADE:
            # FIXME: -----------------------
            stops = true
        CommandType.BUILDING_BASE, \
        CommandType.BUILDING_TOWER, \
        CommandType.BUILDING_FARM, \
        CommandType.BUILDING_BASE_SMALL_UPGRADE, \
        CommandType.BUILDING_BASE_MEDIUM_UPGRADE, \
        CommandType.BUILDING_TOWER_SMALL_UPGRADE, \
        CommandType.BUILDING_TOWER_MEDIUM_UPGRADE, \
        CommandType.BUILDING_FARM_SMALL_UPGRADE, \
        CommandType.BUILDING_FARM_MEDIUM_UPGRADE:
            _on_reached_building_to_build()
            stops = true
        _:
            Sc.logger.error(
                "Worker._on_navigation_ended: command=%s" % \
                str(command.type))
    
    if stops:
        clear_command_state()
        
        if is_initial_nav:
            is_initial_nav = false
            default_behavior = get_behavior(WanderBehavior)
            default_behavior.trigger(false)
        
        Sc.level.on_worker_idleness_changed(self)


func _on_behavior_changed(
        behavior: Behavior,
        previous_behavior: Behavior) -> void:
    if behavior is WanderBehavior or \
            behavior is StaticBehavior:
        # NOTE: This doesn't work, because default behaviors are triggered when
        #       forcing navigation state to be stopped before executing a new
        #       command.
#        if is_instance_valid(command):
#            Sc.logger.warning(
#                "_on_behavior_changed: " +
#                "Worker set to wander or static behavior, " +
#                "with command still active.")
#            clear_command_state()
#        elif !Sc.level.idle_workers.has(self):
#            Sc.logger.warning(
#                "_on_behavior_changed: " +
#                "Worker set to wander or static behavior, " +
#                "but is not registered as idle.")
#            Sc.level.on_worker_idleness_changed(self)
        pass


func _on_radial_menu_touch_up_outside() -> void:
    ._on_radial_menu_touch_up_outside()
    if behavior is StaticBehavior:
        get_behavior(WanderBehavior).trigger(false)


func _on_radial_menu_closed() -> void:
    var wander_behavior := get_behavior(WanderBehavior)
    behavior.next_behavior = wander_behavior
    default_behavior = wander_behavior


func _get_radial_menu_item_types() -> Array:
    var types := [
        CommandType.FRIENDLY_INFO,
    ]
    match worker_type:
        CommandType.SMALL_WORKER:
            types.push_back(CommandType.FRIENDLY_SMALL_UPGRADE)
        CommandType.MEDIUM_WORKER:
            types.push_back(CommandType.FRIENDLY_MEDIUM_UPGRADE)
        CommandType.LARGE_WORKER:
            pass
        _:
            Sc.logger.error("Worker._get_common_radial_menu_item_types")
    return types


func _on_health_depleted() -> void:
    Sc.level.on_worker_health_depleted(self)


func get_is_active() -> bool:
    return is_instance_valid(command)


func get_can_handle_command(type: int) -> bool:
    match type:
        CommandType.FRIENDLY_SMALL_UPGRADE, \
        CommandType.FRIENDLY_MEDIUM_UPGRADE, \
        CommandType.FRIENDLY_RALLY, \
        CommandType.FRIENDLY_MOVE, \
        CommandType.FRIENDLY_STOP, \
        CommandType.BUILDING_BASE, \
        CommandType.BUILDING_TOWER, \
        CommandType.BUILDING_FARM, \
        CommandType.BUILDING_BASE_SMALL_UPGRADE, \
        CommandType.BUILDING_BASE_MEDIUM_UPGRADE, \
        CommandType.BUILDING_TOWER_SMALL_UPGRADE, \
        CommandType.BUILDING_TOWER_MEDIUM_UPGRADE, \
        CommandType.BUILDING_FARM_SMALL_UPGRADE, \
        CommandType.BUILDING_FARM_MEDIUM_UPGRADE, \
        CommandType.BUILDING_OCCUPY, \
        CommandType.BUILDING_VACATE, \
        CommandType.BUILDING_RECYCLE:
            return true
        
        CommandType.BUILDING_EMPTY, \
        CommandType.BUILDING_BASE, \
        CommandType.BUILDING_TOWER, \
        CommandType.BUILDING_FARM, \
        CommandType.BUILDING_STOP, \
        CommandType.BUILDING_INFO, \
        CommandType.HERO, \
        CommandType.SMALL_WORKER, \
        CommandType.MEDIUM_WORKER, \
        CommandType.LARGE_WORKER, \
        CommandType.SMALL_BASE, \
        CommandType.MEDIUM_BASE, \
        CommandType.LARGE_BASE, \
        CommandType.SMALL_TOWER, \
        CommandType.MEDIUM_TOWER, \
        CommandType.LARGE_TOWER, \
        CommandType.SMALL_FARM, \
        CommandType.MEDIUM_FARM, \
        CommandType.LARGE_FARM, \
        CommandType.BUILDING_ENEMY_SPAWN, \
        CommandType.ENEMY_SMALL, \
        CommandType.ENEMY_LARGE:
            return false
        
        CommandType.UNKNOWN, \
        _:
            Sc.logger.error("Worker.get_can_handle_command")
            return false


# FIXME: -----------------
func _on_occupied_building() -> void:
    pass


# FIXME: -----------------
func _on_vacated_building() -> void:
    pass


func _process_sounds() -> void:
    if just_triggered_jump:
        Sc.audio.play_sound("test_character_jump")
    
    if surface_state.just_left_air:
        Sc.audio.play_sound("test_character_land")
    elif surface_state.just_touched_surface:
        Sc.audio.play_sound("test_character_hit_surface")
