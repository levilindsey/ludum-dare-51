tool
class_name Building
extends StationarySelectable


# FIXME: ---------------
var occupying_worker


func _init(entity_command_type: int).(entity_command_type) -> void:
    self.entity_command_type = entity_command_type


func _set_up() -> void:
    _set_up_desaturatable()
    
    ._set_up()


func _destroy() -> void:
    ._destroy()


func _physics_process(delta: float) -> void:
    if Engine.editor_hint:
        return


func _set_up_desaturatable() -> void:
    var sprites: Array = \
        Sc.utils.get_children_by_type(self, OutlineableSprite, true)
    var animated_sprites: Array = \
        Sc.utils.get_children_by_type(self, OutlineableAnimatedSprite, true)
    for collection in [sprites, animated_sprites]:
        for node in collection:
            node.is_desaturatable = true


func _build_structure(button_type: int) -> void:
    Sc.logger.error("Abstract Building._build_structure is not implemented")


func _on_camera_enter() -> void:
    ._on_camera_enter()


func _on_camera_exit() -> void:
    ._on_camera_exit()


func get_center() -> Vector2:
    return position + $Center.position


func get_position_along_surface(
        character: SurfacerCharacter) -> PositionAlongSurface:
    var surface := SurfaceFinder.find_closest_surface_in_direction(
        character.surface_store,
        self.position,
        Vector2.DOWN)
    return PositionAlongSurfaceFactory.create_position_offset_from_target_point(
        self.position,
        surface,
        character.collider,
        true,
        true)


func _on_hit_by_projectile(projectile) -> void:
    Sc.level.session.projectiles_collided_count += 1
    modify_health(-projectile.damage)


func _on_health_depleted() -> void:
    Sc.level.on_building_health_depleted(self)


func _on_touch_down(
        level_position: Vector2,
        is_already_handled: bool) -> void:
    set_is_selected(true)
    
    open_radial_menu()


func _on_button_pressed(button_type: int) -> void:
    ._on_button_pressed(button_type)
    
    match button_type:
        CommandType.BUILDING_RECYCLE:
            # FIXME: ---------------------------
#            Sc.audio.play_sound("command_finished")
            set_is_selected(false)
            update_info_panel_visibility(false)
            Sc.level.add_command(CommandType.BUILDING_RECYCLE, self)
        
        CommandType.BUILDING_INFO:
            set_is_selected(true)
            update_info_panel_visibility(true)
        
        CommandType.BUILDING_BASE_SMALL_UPGRADE, \
        CommandType.BUILDING_BASE_MEDIUM_UPGRADE, \
        CommandType.BUILDING_TOWER_SMALL_UPGRADE, \
        CommandType.BUILDING_TOWER_MEDIUM_UPGRADE, \
        CommandType.BUILDING_FARM_SMALL_UPGRADE, \
        CommandType.BUILDING_FARM_MEDIUM_UPGRADE, \
        CommandType.SMALL_TOWER, \
        CommandType.MEDIUM_TOWER, \
        CommandType.LARGE_TOWER, \
        CommandType.MEDIUM_BASE, \
        CommandType.LARGE_BASE:
            # FIXME: ---------------------------
#            Sc.audio.play_sound("command_finished")
            set_is_selected(false)
            update_info_panel_visibility(false)
            _upgrade_building(button_type)
        
        CommandType.BUILDING_OCCUPY:
            # FIXME: ---------------------------
#            Sc.audio.play_sound("command_finished")
            Sc.level.add_command(CommandType.BUILDING_OCCUPY, self)
        
        CommandType.BUILDING_VACATE:
            # FIXME: ---------------------------
#            Sc.audio.play_sound("command_finished")
            assert(is_instance_valid(occupying_worker))
            occupying_worker._on_vacated_building()
            occupying_worker = null
        
        CommandType.FRIENDLY_RALLY:
            if is_instance_valid(Sc.level.hero):
                Sc.level.rally(get_position_along_surface(Sc.level.hero))
        
        _:
            Sc.logger.error("Building._on_button_pressed")


func _upgrade_building(button_type: int) -> void:
    var new_building_type: int
    match button_type:
        CommandType.BUILDING_TOWER, \
        CommandType.SMALL_TOWER:
            assert(entity_command_type == CommandType.BUILDING_EMPTY)
            new_building_type = CommandType.SMALL_TOWER
        CommandType.BUILDING_BASE_SMALL_UPGRADE, \
        CommandType.MEDIUM_BASE:
            assert(entity_command_type == CommandType.SMALL_BASE)
#            new_building_type = CommandType.MEDIUM_BASE
            Sc.level.session.base_upgrade_count += 1
            
            for collection in [[Sc.level.hero], Sc.level.workers, Sc.level.enemies, Sc.level.buildings]:
                for unit in collection:
                    # FIXME: -------------------------
                    unit._health *= 1.2
                    unit._health_capacity *= 1.2
            
            
            
        CommandType.BUILDING_BASE_MEDIUM_UPGRADE, \
        CommandType.LARGE_BASE:
            assert(entity_command_type == CommandType.MEDIUM_BASE)
            new_building_type = CommandType.LARGE_BASE
        CommandType.BUILDING_TOWER_SMALL_UPGRADE, \
        CommandType.MEDIUM_TOWER:
            assert(entity_command_type == CommandType.SMALL_TOWER)
            new_building_type = CommandType.MEDIUM_TOWER
        CommandType.BUILDING_TOWER_MEDIUM_UPGRADE, \
        CommandType.LARGE_TOWER:
            assert(entity_command_type == CommandType.MEDIUM_TOWER)
            new_building_type = CommandType.LARGE_TOWER
        CommandType.BUILDING_FARM_SMALL_UPGRADE:
            assert(entity_command_type == CommandType.SMALL_FARM)
            new_building_type = CommandType.MEDIUM_FARM
        CommandType.BUILDING_FARM_MEDIUM_UPGRADE:
            assert(entity_command_type == CommandType.MEDIUM_FARM)
            new_building_type = CommandType.LARGE_FARM
        _:
            Sc.logger.error("Building._upgrade_building")
            return
    Sc.level.deduct_money(CommandType.COSTS[button_type])
    Sc.level.replace_building(self, new_building_type)


func _get_common_radial_menu_item_types() -> Array:
    return [
        CommandType.BUILDING_RECYCLE,
        CommandType.BUILDING_INFO,
    ]


func _on_command_enablement_changed() -> void:
    ._on_command_enablement_changed()


func set_is_selected(is_selected: bool) -> void:
    if is_selected == get_is_selected():
        # No change.
        return
    .set_is_selected(is_selected)
    Sc.level._on_building_selection_changed(self, is_selected)


func get_is_selected() -> bool:
    return Sc.level.selected_building == self


func get_radial_position_in_screen_space() -> Vector2:
    return Sc.utils.get_screen_position_of_node_in_level($Center)


func _update_highlight() -> void:
    active_outline_alpha_multiplier = \
        _MAX_HIGHLIGHT_OPACITY_FOR_VIEWPORT_POSITION * \
        _MAX_HIGHLIGHT_OPACITY_FOR_VIEWPORT_POSITION
    if interaction_mode == InteractionMode.HOVER or \
            interaction_mode == InteractionMode.PRESSED:
        outline_color = Sc.palette.get_color("building_hovered")
    elif get_is_selected():
        outline_color = Sc.palette.get_color("building_selected")
    else:
        outline_color = _get_normal_highlight_color()
        active_outline_alpha_multiplier = \
            viewport_position_outline_alpha_multiplier
    _update_outline()


func get_disabled_message(command_type: int) -> String:
    var message: String = Sc.level.command_enablement[command_type]
    if message != "":
        return message
    match command_type:
        # FIXME: ---------------------
        _:
            pass
    return ""


func _get_health_capacity() -> int:
    var base_capacity: int = Health.get_default_capacity(entity_command_type)
    
    # FIXME: -------------------------
    # - Modify health-capacity for Upgrade.
    
    return base_capacity
