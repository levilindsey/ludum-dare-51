tool
class_name Friendly
extends SurfacerCharacter


const _LIGHT_TEXTURE := preload(
    "res://addons/scaffolder/assets/images/misc/circle_gradient_modified_1024.png")

const MIN_OPACITY_MULTIPLIER := 0.3
const MAX_OPACITY_MULTIPLIER := 1.0

const POINTER_DISTANCE_SQUARED_OFFSET_FOR_SELECTION_PRIORITY := 30.0 * 30.0

export var projectile_launch_offset := Vector2.ZERO

var status_overlay: StatusOverlay

var entity_command_type := CommandType.UNKNOWN
func get_entity_type() -> int:
    return entity_command_type

var _health := 0
var _health_capacity := 0

var status := FriendlyStatus.UNKNOWN

var light: Light2D

var is_selected := false
var is_new := true
var is_hovered := false
var is_initial_nav := false

var viewport_position_outline_alpha_multiplier := 0.0


func _init(entity_command_type: int) -> void:
    self.entity_command_type = entity_command_type
    
    if Engine.editor_hint:
        return
    
    _health_capacity = _get_health_capacity()
    _health = _health_capacity
    
    light = Light2D.new()
    light.texture = _LIGHT_TEXTURE
    light.texture_scale = 0.1
    light.range_layer_min = -100
    light.range_layer_max = 100
    light.range_item_cull_mask = 2
    light.shadow_item_cull_mask = 2
    add_child(light)
    light.owner = self
    
    _update_status()


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
        POINTER_DISTANCE_SQUARED_OFFSET_FOR_SELECTION_PRIORITY)
    
    status_overlay = \
        Sc.utils.add_scene(self, StationarySelectable._STATUS_OVERLAY_SCENE)
    status_overlay.entity = self
    status_overlay.anchor_y = -collider.half_width_height.y
    status_overlay.z_index = 1
    status_overlay.set_up()
    
    is_initial_nav = true
    is_new = true


func _destroy() -> void:
    update_info_panel_visibility(false)
    close_radial_menu()
    ._destroy()


func _physics_process(delta: float) -> void:
    if Engine.editor_hint:
        return
    
    if did_move_last_frame:
        _update_highlight_for_camera_position()


func _on_level_started() -> void:
    pass


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
    Sc.level._on_friendly_selection_changed(self, is_selected)
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
    elif is_new:
        status = FriendlyStatus.NEW
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
    opacity = lerp(MIN_OPACITY_MULTIPLIER, MAX_OPACITY_MULTIPLIER, opacity)
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
            Sc.logger.error("Friendly._on_started_colliding: layer_names=%s" % \
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
    pass


func get_projectile_launch_position() -> Vector2:
    return position + \
        projectile_launch_offset * \
        Vector2(surface_state.horizontal_facing_sign, 1.0)
