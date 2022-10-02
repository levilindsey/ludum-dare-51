tool
class_name Enemy
extends SurfacerCharacter


const MODERATE_MODULATION := Color("8284ff")
const MAJOR_MODULATION := Color("ff7373")

const _FIRING_RANGE_SCENE := preload("res://src/firing_range.tscn")

export var projectile_launch_offset := Vector2.ZERO

var status_overlay: StatusOverlay

var entity_command_type := CommandType.UNKNOWN
func get_entity_type() -> int:
    return entity_command_type

var upgrade_type := UpgradeType.UNKNOWN

var _health := 0
var _health_capacity := 0

var status := FriendlyStatus.UNKNOWN

var light: Light2D

var is_selected := false
var is_hovered := false
var is_initial_nav := false

var viewport_position_outline_alpha_multiplier := 0.0

var firing_range: FiringRange

var shooting_target = null

var firing_targets := {}

var firing_interval := INF

var shot_start_time := -1.0


func _init(entity_command_type: int) -> void:
    self.entity_command_type = entity_command_type
    
    if Engine.editor_hint:
        return
    
    _health_capacity = _get_health_capacity()
    _health = _health_capacity
    
    light = Light2D.new()
    light.texture = Friendly._LIGHT_TEXTURE
    light.texture_scale = 0.1
    light.range_layer_min = -100
    light.range_layer_max = 100
    light.range_item_cull_mask = 2
    light.shadow_item_cull_mask = 2
    add_child(light)
    light.owner = self
    
    _update_status()


func set_upgrade_type(upgrade_type: int) -> void:
    self.upgrade_type = upgrade_type
    
    # FIXME: -------------------
    # - Modulate color for upgrades.
    # - Increase health attack and range for higher upgrades.
    
    match upgrade_type:
        UpgradeType.MINOR:
            pass
        UpgradeType.MODERATE:
            self.modulate = MODERATE_MODULATION
        UpgradeType.MAJOR:
            self.modulate = MAJOR_MODULATION
        _:
            Sc.logger.error("Enemy.set_upgrade_type")


func _ready() -> void:
    if Engine.editor_hint:
        return
    
    for light in Sc.utils.get_children_by_type(self, Light2D):
        if light != self.light:
            remove_child(light)
    
    Sc.info_panel.connect("closed", self, "_on_info_panel_closed")
    detects_pointer = true
    pointer_screen_radius = \
        Sc.device.inches_to_pixels(StationarySelectable.SCREEN_RADIUS_INCHES)
    _set_pointer_distance_squared_offset_for_selection_priority(
        Friendly.POINTER_DISTANCE_SQUARED_OFFSET_FOR_SELECTION_PRIORITY)
    
    status_overlay = \
        Sc.utils.add_scene(self, StationarySelectable._STATUS_OVERLAY_SCENE)
    status_overlay.entity = self
    status_overlay.anchor_y = -collider.half_width_height.y
    status_overlay.z_index = 1
    status_overlay.set_up()
    
    is_initial_nav = true
    
    navigator.connect("navigation_started", self, "_on_navigation_started")
    navigator.connect("navigation_ended", self, "_on_navigation_ended")
    
    _set_up_firing_range()
    
    _go_to_base()


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
    if area.get_entity_type() == CommandType.BUILDING_EMPTY:
        return
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
    if area.get_entity_type() == CommandType.BUILDING_EMPTY:
        return
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
    _go_to_base()

func get_is_shooting() -> bool:
    return is_instance_valid(shooting_target)

func _update_shooting() -> void:
    if !get_is_shooting():
        return
    var shot_current_time := Game.scaled_play_time
    while shot_current_time - shot_start_time > firing_interval:
        shot_start_time += firing_interval
        
        var tower_upgrade_type := UpgradeType.UNKNOWN
        Sc.level.projectile_controller.shoot_at_target(
            entity_command_type,
            upgrade_type,
            tower_upgrade_type,
            shooting_target.position,
            get_projectile_launch_position())


func _destroy() -> void:
    update_info_panel_visibility(false)
    close_radial_menu()
    ._destroy()


func _physics_process(delta: float) -> void:
    if Engine.editor_hint:
        return
    if _is_destroyed:
        return
    
    _update_shooting()
    
    if did_move_last_frame:
        _update_highlight_for_camera_position()
    
    if position.y > 4000:
        Sc.level.remove_enemy(self)


func _on_level_started() -> void:
    pass


func _go_to_base() -> void:
    var target_point := Vector2(
        Sc.level.base.get_bounds().end.x,
        Sc.level.base.position.y)
    var surface: Surface = \
        Sc.level.base.get_position_along_surface(self).surface
    var destination := PositionAlongSurfaceFactory \
        .create_position_offset_from_target_point(
            target_point, surface, collider, true)
    navigate_imperatively(destination)


func _on_touch_down(
        level_position: Vector2,
        is_already_handled: bool) -> void:
    ._on_touch_down(level_position, is_already_handled)
    
    if is_selected:
        set_is_selected(false)
    else:
        set_is_selected(true)
        
        open_radial_menu()


func _on_touch_up(
        level_position: Vector2,
        is_already_handled: bool) -> void:
    ._on_touch_up(level_position, is_already_handled)
    Sc.level.touch_listener.set_current_touch_as_not_handled()


func _on_interaction_mode_changed(interaction_mode: int) -> void:
    is_hovered = false
    match interaction_mode:
        LevelControl.InteractionMode.HOVER, \
        LevelControl.InteractionMode.PRESSED:
            is_hovered = true
        _:
            pass
    _update_status()


func set_is_selected(is_selected: bool) -> void:
    if self.is_selected == is_selected:
        # No change.
        return
    self.is_selected = is_selected
    Sc.level._on_enemy_selection_changed(self, is_selected)
    _update_status()


func open_radial_menu() -> void:
    var radial_menu: GameRadialMenu = Sc.gui.hud.open_radial_menu(
        Sc.gui.hud.radial_menu_class,
        _get_radial_menu_items(),
        self.get_position_in_screen_space(),
        self)
    radial_menu.connect(
        "touch_up_item", self, "_on_radial_menu_item_selected")
    radial_menu.connect(
        "touch_up_center", self, "_on_radial_menu_touch_up_center")
    radial_menu.connect(
        "touch_up_outside", self, "_on_radial_menu_touch_up_outside")
    radial_menu.connect(
        "closed", self, "_on_radial_menu_closed")


func close_radial_menu() -> void:
    if Sc.gui.hud.get_is_radial_menu_open() and \
            Sc.gui.hud._radial_menu.metadata == self:
        Sc.gui.hud.close_radial_menu()


func get_is_own_info_panel_shown() -> bool:
    var data: InfoPanelData = Sc.info_panel.get_current_data()
    return is_instance_valid(data) and data.meta == self


func update_info_panel_contents() -> void:
    if !get_is_own_info_panel_shown():
        return
    var data: InfoPanelData = Sc.info_panel.get_current_data()
    data.contents.update()


func update_info_panel_visibility(is_visible: bool) -> void:
    if is_visible:
        if !get_is_own_info_panel_shown():
            var contents = Game.INFO_PANEL_CONTENTS_SCENE.instance()
            contents.set_up(self)
            Sc.info_panel.show_panel(contents.get_data())
    else:
        if get_is_own_info_panel_shown():
            Sc.info_panel.close_panel()


func _update_status() -> void:
    var previous_status := status
    if is_hovered:
        status = FriendlyStatus.HOVERED
    elif is_selected:
        status = FriendlyStatus.SELECTED
    else:
        status = FriendlyStatus.IDLE
#    Sc.logger.print("Friendly._update_status: %s" % FriendlyStatus.get_string(status))
    if status != previous_status:
        update_highlight()
        _on_command_enablement_changed()


func update_highlight() -> void:
    var outline_alpha_multiplier := \
        viewport_position_outline_alpha_multiplier if \
        (status == FriendlyStatus.ACTIVE || \
            status == FriendlyStatus.IDLE) else \
        1.0
    
    var config: Dictionary = FriendlyStatus.HIGHLIGHT_CONFIGS[status]
    
    light.color = Sc.palette.get_color(config.color)
    light.texture_scale = config.scale
    light.energy = config.energy * outline_alpha_multiplier
    
    if is_instance_valid(animator):
        var outline_color: Color = Sc.palette.get_color(config.color)
        outline_color.a *= \
            config.outline_alpha_multiplier * outline_alpha_multiplier
        animator.outline_color = outline_color
        animator.is_outlined = outline_color.a > 0.0


func _on_panned() -> void:
    _update_highlight_for_camera_position()


func _on_zoomed() -> void:
    _update_highlight_for_camera_position()


func _update_highlight_for_camera_position() -> void:
    var opacity := StationarySelectable.get_opacity_for_camera_position(self.global_position)
    opacity = lerp(Friendly.MIN_OPACITY_MULTIPLIER, Friendly.MAX_OPACITY_MULTIPLIER, opacity)
    viewport_position_outline_alpha_multiplier = opacity
    status_overlay.modulate.a = viewport_position_outline_alpha_multiplier
    update_highlight()


func _on_info_panel_closed(data: InfoPanelData) -> void:
    set_is_selected(false)


func _on_started_colliding(
        target: Node2D,
        layer_names: Array) -> void:
    match layer_names[0]:
        _:
            Sc.logger.error("Enemy._on_started_colliding: layer_names=%s" % \
                  str(layer_names))


func _on_hit_by_projectile(projectile) -> void:
    Sc.level.session.projectiles_collided_count += 1
    # FIXME: --------------- Consider modifying damage depending on Upgrade.
    var damage: int = projectile.damage
    modify_health(-damage)


func _on_radial_menu_item_selected(item: RadialMenuItem) -> void:
    match item.id:
        CommandType.FRIENDLY_INFO:
            set_is_selected(true)
            update_info_panel_visibility(true)
        _:
            Sc.logger.error("Friendly._on_radial_menu_item_selected")


func _on_radial_menu_touch_up_center() -> void:
    _on_radial_menu_touch_up_outside()


func _on_radial_menu_touch_up_outside() -> void:
    set_is_selected(false)


func _on_radial_menu_closed() -> void:
    pass


func _process_sounds() -> void:
    if just_triggered_jump:
        Sc.audio.play_sound("test_character_jump")
    
    if surface_state.just_left_air:
        Sc.audio.play_sound("test_character_land")
    elif surface_state.just_touched_surface:
            Sc.audio.play_sound("test_character_land")


func _get_radial_menu_item_types() -> Array:
    return [
        CommandType.FRIENDLY_INFO,
    ]


func _get_radial_menu_items() -> Array:
    var types := _get_radial_menu_item_types()
    var result := []
    for type in types:
        var command_item := GameRadialMenuItem.new()
        command_item.cost = CommandType.COSTS[type]
        command_item.id = type
        command_item.description = CommandType.COMMAND_LABELS[type]
        command_item.texture = CommandType.TEXTURES[type]
        command_item.disabled_message = get_disabled_message(type)
        result.push_back(command_item)
    return result


func _on_command_enablement_changed() -> void:
    update_info_panel_contents()
    if Sc.gui.hud.get_is_radial_menu_open() and \
            Sc.gui.hud._radial_menu.metadata == self:
        for item in Sc.gui.hud._radial_menu._items:
            item.disabled_message = get_disabled_message(item.id)


func get_disabled_message(command_type: int) -> String:
    var message: String = Sc.level.command_enablement[command_type]
    if message != "":
        return message
    match command_type:
        # FIXME: --------------
        _:
            pass
    return ""


func get_health() -> int:
    return _health


func get_health_capacity() -> int:
    return _health_capacity


func _get_health_capacity() -> int:
    var base_capacity: int = Health.get_default_capacity(entity_command_type)
    
    # FIXME: -------------------------
    # - Modify health-capacity for Upgrade.
    
    return base_capacity


func modify_health(diff: int) -> void:
    var previous_health := _health
    _health = clamp(_health + diff, 0, _health_capacity)
    if _health == previous_health:
        return
    update_info_panel_contents()
    status_overlay.update()
    if _health == 0:
        _on_health_depleted()


func _on_health_depleted() -> void:
    # FIXME: ------------------------- Play sound
    Sc.level.remove_enemy(self)


func stop_on_surface(triggers_wander := false) -> void:
    .stop_on_surface()


func _stop_nav_immediately() -> void:
    ._stop_nav_immediately()


func _on_navigation_started(
        is_retry: bool,
        triggered_by_player: bool) -> void:
    pass


func _on_navigation_ended(
        did_reach_destination := true,
        triggered_by_player := false) -> void:
    pass


func _on_behavior_changed(
        behavior: Behavior,
        previous_behavior: Behavior) -> void:
    pass


func get_projectile_launch_position() -> Vector2:
    return position + \
        projectile_launch_offset * \
        Vector2(surface_state.horizontal_facing_sign, 1.0)
