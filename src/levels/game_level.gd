tool
class_name GameLevel
extends SurfacerLevel


const _HERO_SCENE := preload(
    "res://src/characters/hero/hero.tscn")
# FIXME: --------------
#const _FRIENDLY_SMALL_WORKER_SCENE := preload(
#    "res://src/characters/worker/small_worker.tscn")
#const _FRIENDLY_MEDIUM_WORKER_SCENE := preload(
#    "res://src/characters/worker/medium_worker.tscn")
#const _FRIENDLY_LARGE_WORKER_SCENE := preload(
#    "res://src/characters/worker/large_worker.tscn")
const _FRIENDLY_SMALL_WORKER_SCENE := preload(
    "res://src/characters/worker/worker.tscn")
const _FRIENDLY_MEDIUM_WORKER_SCENE := preload(
    "res://src/characters/worker/worker.tscn")
const _FRIENDLY_LARGE_WORKER_SCENE := preload(
    "res://src/characters/worker/worker.tscn")
const _SMALL_ENEMY_SCENE := preload(
    "res://src/characters/small_enemy/small_enemy.tscn")
const _LARGE_ENEMY_SCENE := preload(
    "res://src/characters/large_enemy/large_enemy.tscn")

const _EMPTY_STRUCTURE_SCENE := preload(
    "res://src/buildings/empty_structure.tscn")
# FIXME: -------------------
#const _SMALL_BASE_SCENE := preload(
#    "res://src/buildings/small_base.tscn")
#const _MEDIUM_BASE_SCENE := preload(
#    "res://src/buildings/medium_base.tscn")
#const _LARGE_BASE_SCENE := preload(
#    "res://src/buildings/large_base.tscn")
#const _SMALL_TOWER_SCENE := preload(
#    "res://src/buildings/small_tower.tscn")
#const _MEDIUM_TOWER_SCENE := preload(
#    "res://src/buildings/medium_tower.tscn")
#const _LARGE_TOWER_SCENE := preload(
#    "res://src/buildings/large_tower.tscn")
#const _SMALL_FARM_SCENE := preload(
#    "res://src/buildings/small_farm.tscn")
#const _MEDIUM_FARM_SCENE := preload(
#    "res://src/buildings/medium_farm.tscn")
#const _LARGE_FARM_SCENE := preload(
#    "res://src/buildings/large_farm.tscn")
const _SMALL_BASE_SCENE := preload(
    "res://src/buildings/small_base.tscn")
const _MEDIUM_BASE_SCENE := preload(
    "res://src/buildings/small_base.tscn")
const _LARGE_BASE_SCENE := preload(
    "res://src/buildings/small_base.tscn")
const _SMALL_TOWER_SCENE := preload(
    "res://src/buildings/small_base.tscn")
const _MEDIUM_TOWER_SCENE := preload(
    "res://src/buildings/small_base.tscn")
const _LARGE_TOWER_SCENE := preload(
    "res://src/buildings/small_base.tscn")
const _SMALL_FARM_SCENE := preload(
    "res://src/buildings/small_base.tscn")
const _MEDIUM_FARM_SCENE := preload(
    "res://src/buildings/small_base.tscn")
const _LARGE_FARM_SCENE := preload(
    "res://src/buildings/small_base.tscn")

const _FRIENDLY_PROJECTILE_SCENE := preload(
    "res://src/projectiles/friendly_projectile.tscn")
const _SMALL_ENEMY_PROJECTILE_SCENE := preload(
    "res://src/projectiles/small_enemy_projectile.tscn")
const _LARGE_ENEMY_PROJECTILE_SCENE := preload(
    "res://src/projectiles/large_enemy_projectile.tscn")

var _static_camera: StaticCamera
var _follow_camera: FollowCharacterCamera

var hero: Hero
var base: Base

var selected_building: Building
var previous_selected_building: Building

var selected_friendly: Friendly
var previous_selected_friendly: Friendly

var selected_enemy: Enemy
var previous_selected_enemy: Enemy

# Array<Building>
var buildings := []

# Array<EmptyStructure>
var empty_structures := []

# Array<EnemySpawn>
var enemy_spawn_points := []

# Array<Worker>
var workers := []

# Array<Enemy>
var enemies := []

# Array<Projectile>
var projectiles := []

# Dictionary<Worker, true>
var idle_workers := {}

# Array<Command>
var command_queue := []

# Dictionary<Command, true>
var in_progress_commands := {}

# Array<String>
var command_enablement := []

# Array<String>
var previous_command_enablement := []

var _is_money_based_command_enablement_update_pending := false
var _is_try_next_command_pending := false

var _max_command_cost := -INF

var worker_spawn_controller: WorkerSpawnController
var enemy_spawn_controller: EnemySpawnController
var projectile_controller: ProjectileController


func _ready() -> void:
    if Engine.editor_hint:
        return
    
    _static_camera = StaticCamera.new()
    add_child(_static_camera)
    
    for command in CommandType.VALUES:
        _max_command_cost = max(_max_command_cost, CommandType.COSTS[command])
    
    command_enablement.resize(CommandType.VALUES.size())
    for command in CommandType.VALUES:
        command_enablement[command] = ""
    previous_command_enablement = command_enablement.duplicate()


func _load() -> void:
    ._load()
    
    if Engine.editor_hint:
        return
    
    Sc.gui.hud.set_up()
    Sc.gui.hud.connect(
        "radial_menu_opened",
        self,
        "_on_radial_menu_opened")
    Sc.gui.hud.connect(
        "radial_menu_closed",
        self,
        "_on_radial_menu_closed")


func _start() -> void:
    ._start()
    
    if Engine.editor_hint:
        return
    
    hero = Sc.utils.get_child_by_type(self, Hero)
    
    _follow_camera = FollowCharacterCamera.new()
    add_child(_follow_camera)
    
    _follow_camera.target_character = hero
    swap_camera(_follow_camera, false)
    
    base = Sc.utils.get_child_by_type($Structures, Base)
    _on_building_created(base, true)
    
    var empty_structures := \
        Sc.utils.get_children_by_type($Structures, EmptyStructure)
    for empty_structure in empty_structures:
        _on_building_created(empty_structure, true)
    
    var enemy_spawn_points := \
        Sc.utils.get_children_by_type($Structures, EnemySpawn)
    for enemy_spawn_point in enemy_spawn_points:
        _on_building_created(enemy_spawn_point, true)
    
    session.total_enemy_spawn_point_count = enemy_spawn_points.size()
    
    base._on_level_started()
    hero._on_level_started()
    for empty_structure in empty_structures:
        empty_structure._on_level_started()
    for enemy_spawn_point in enemy_spawn_points:
        enemy_spawn_point._on_level_started()
    
    update_command_enablement()
    
    session._score = session.total_money
    
    Sc.camera.connect("panned", self, "_on_panned")
    Sc.camera.connect("zoomed", self, "_on_zoomed")
    
    worker_spawn_controller = WorkerSpawnController.new()
    add_child(worker_spawn_controller)
    
    enemy_spawn_controller = EnemySpawnController.new()
    add_child(enemy_spawn_controller)
    
    projectile_controller = ProjectileController.new()
    add_child(projectile_controller)


func _destroy() -> void:
    for building in buildings:
        building._destroy()
    
    ._destroy()


#func _on_initial_input() -> void:
#    ._on_initial_input()


func quit(
        has_finished: bool,
        immediately: bool) -> void:
    if has_finished:
        session._game_over_explanation = Description.LEVEL_SUCCESS_EXPLANATION
    else:
        session._game_over_explanation = Description.LEVEL_FAILURE_EXPLANATION
    .quit(has_finished, immediately)


#func _on_intro_choreography_finished() -> void:
#    ._on_intro_choreography_finished()


#func pause() -> void:
#    .pause()


#func on_unpause() -> void:
#    .on_unpause()


func _unhandled_input(event: InputEvent) -> void:
    if (event is InputEventScreenTouch or \
            event is InputEventMouseButton) and \
            event.pressed:
        # Close the info panel if it wasn't just opened.
        if Sc.info_panel.get_is_open() and \
                !Sc.info_panel.get_is_transitioning():
            Sc.info_panel.close_panel()
            _clear_selection()


func _on_panned() -> void:
    hero._on_panned()
    for worker in workers:
        worker._on_panned()
    for enemy in enemies:
        enemy._on_panned()
    for building in buildings:
        building._on_panned()


func _on_zoomed() -> void:
    hero._on_zoomed()
    for worker in workers:
        worker._on_zoomed()
    for enemy in enemies:
        enemy._on_zoomed()
    for building in buildings:
        building._on_zoomed()


func _on_radial_menu_opened() -> void:
    _update_camera()


func _on_radial_menu_closed() -> void:
    _update_camera()


func _on_friendly_selection_changed(
        friendly: Friendly,
        is_selected: bool) -> void:
    if is_selected:
        # Deselect any previously selected friendly.
        if is_instance_valid(selected_friendly):
            if friendly == selected_friendly:
                # No change.
                return
            else:
                selected_friendly.set_is_selected(false)
        _update_selected_friendly(friendly)
    else:
        if friendly != selected_friendly:
            # No change.
            return
        _update_selected_friendly(null)
    
    # Deselect any selected building.
    if is_selected and \
            is_instance_valid(selected_building):
        selected_building.set_is_selected(false)
        _update_selected_building(null)


func _on_enemy_selection_changed(
        enemy: Enemy,
        is_selected: bool) -> void:
    if is_selected:
        # Deselect any previously selected enemy.
        if is_instance_valid(selected_enemy):
            if enemy == selected_enemy:
                # No change.
                return
            else:
                selected_enemy.set_is_selected(false)
        _update_selected_enemy(enemy)
    else:
        if enemy != selected_enemy:
            # No change.
            return
        _update_selected_enemy(null)
    
    # Deselect any selected building.
    if is_selected and \
            is_instance_valid(selected_building):
        selected_building.set_is_selected(false)
        _update_selected_building(null)


func _on_building_selection_changed(
        building: Building,
        is_selected: bool) -> void:
    if is_selected:
        # Deselect any previously selected building.
        if is_instance_valid(selected_building):
            if building == selected_building:
                # No change.
                return
            else:
                selected_building.set_is_selected(false)
        _update_selected_building(building)
    else:
        if building != selected_building:
            # No change.
            return
        _update_selected_building(null)
    
    # Deselect any selected friendly.
    if is_selected and \
            is_instance_valid(selected_friendly):
        selected_friendly.set_is_selected(false)
        _update_selected_friendly(null)
    
    # Deselect any selected enemy.
    if is_selected and \
            is_instance_valid(selected_enemy):
        selected_enemy.set_is_selected(false)
        _update_selected_enemy(null)


func _clear_selection() -> void:
    if is_instance_valid(selected_friendly):
        selected_friendly.set_is_selected(false)
        _update_selected_friendly(null)
    if is_instance_valid(selected_enemy):
        selected_enemy.set_is_selected(false)
        _update_selected_enemy(null)
    if is_instance_valid(selected_building):
        selected_building.set_is_selected(false)
        _update_selected_building(null)


func _update_selected_friendly(selected_friendly: Friendly) -> void:
    if self.selected_friendly == selected_friendly:
        return
    previous_selected_friendly = self.selected_friendly
    self.selected_friendly = selected_friendly


func _update_selected_enemy(selected_enemy: Enemy) -> void:
    if self.selected_enemy == selected_enemy:
        return
    previous_selected_enemy = self.selected_enemy
    self.selected_enemy = selected_enemy


func _update_selected_building(selected_building: Building) -> void:
    if self.selected_building == selected_building:
        return
    previous_selected_building = self.selected_building
    self.selected_building = selected_building


func _update_camera() -> void:
    var extra_zoom: float
    if Sc.gui.hud.get_is_radial_menu_open():
        extra_zoom = 1.3
    else:
        extra_zoom = 1.0
    camera.transition_extra_zoom(extra_zoom)


func add_command(
        type: int,
        target_building: Building,
        next_target_building: Building = null,
        destination: PositionAlongSurface = null,
        meta = null) -> void:
    var command := Command.new(
        type,
        target_building,
        next_target_building,
        destination,
        meta)
    command_queue.push_back(command)
    _try_next_command()


func _try_next_command() -> void:
    if !_is_try_next_command_pending:
        _is_try_next_command_pending = true
        call_deferred("_try_next_command_deferred")


func _try_next_command_deferred() -> void:
    _is_try_next_command_pending = false
    
    var i := 0
    while i < command_queue.size():
        var command: Command = command_queue[i]
        
        if !_get_is_command_still_valid(command):
            # FIXME: ----------- Play (throttled) error sound.
            command_queue.remove(i)
            continue
        
        var worker := _get_worker_for_command(command)
        if !is_instance_valid(worker):
            # No idle worker was able to handle the command.
            i += 1
            continue
        
        command_queue.remove(i)
        worker.start_command(command)
        
        if idle_workers.empty():
            break


func _get_is_command_still_valid(command: Command) -> bool:
    if !is_instance_valid(command.target_building) and \
            command.get_depends_on_target_building():
        # Building has been freed.
        Sc.logger.warning(
            "GameLevel._try_next_command_deferred: " +
            "command.target_building has been freed.")
        return false
    
    if !get_is_enough_money_for_command(command):
        # Not enough money for command.
        return false
    
    return true


func cancel_command(
        command: Command,
        already_canceled_worker := false) -> void:
    command_queue.erase(command)
    in_progress_commands.erase(command)
    if !already_canceled_worker and \
            is_instance_valid(command.worker):
        command.worker.clear_command_state()
        on_worker_idleness_changed(command.worker)
        command.worker.stop_on_surface(true)
        return


func get_is_enough_money_for_command(command: Command) -> bool:
    return session.current_money >= CommandType.COSTS[command.type]


func deduct_money(cost: int) -> void:
    var previous_money: int = session.current_money
    session.current_money -= cost
    session.current_money = max(session.current_money, 0)
    _update_money_based_command_enablement()


func add_money(money: int) -> void:
    var previous_money: int = session.current_money
    session.current_money += money
    session.total_money += money
    session._score = session.total_money
    _update_money_based_command_enablement()


func _update_money_based_command_enablement() -> void:
    if !_is_money_based_command_enablement_update_pending:
        _is_money_based_command_enablement_update_pending = true
        call_deferred("_update_money_based_command_enablement_deferred")


func _update_money_based_command_enablement_deferred(
        is_part_of_general_enablement_update := false) -> void:
    _is_money_based_command_enablement_update_pending = false
    
    # Disable any command for which there isn't enough money.
    if session.current_money < _max_command_cost:
        for command in CommandType.VALUES:
            var previous_enablement: String = command_enablement[command]
            var is_enough_money: bool = \
                CommandType.COSTS[command] <= session.current_money
            
            # Don't override other disablement messages.
            if previous_enablement == "" and \
                    !is_enough_money:
                command_enablement[command] = Description.NOT_ENOUGH_MONEY
                
            elif previous_enablement == Description.NOT_ENOUGH_MONEY and \
                    is_enough_money:
                command_enablement[command] = ""
    
    if !is_part_of_general_enablement_update:
        _check_for_command_enablement_changed()


func update_command_enablement() -> void:
    # Clear command-enablement.
    for command in CommandType.VALUES:
        command_enablement[command] = ""
    
    # FIXME: -----------------------
    
    _update_money_based_command_enablement_deferred(true)
    
    _check_for_command_enablement_changed()


func _check_for_command_enablement_changed() -> void:
    var changed := false
    for i in command_enablement.size():
        if command_enablement[i] != previous_command_enablement[i]:
            changed = true
            break
    
    if changed:
        previous_command_enablement = command_enablement.duplicate()
        for entities in [[hero], workers, buildings]:
            for entity in entities:
                entity._on_command_enablement_changed()


func _get_worker_for_command(command: Command) -> Worker:
    var closest_distance_squared := INF
    var closest_worker: Worker = null
    for worker in idle_workers.keys():
        if !is_instance_valid(worker):
            Sc.logger.warning(
                "GameLevel.get_worker_for_command: " +
                "worker has been freed.")
            idle_workers.erase(worker)
            continue
        var current_distance_squared: float = \
            worker.position.distance_squared_to(command.get_position()) if \
            worker.get_can_handle_command(command.type) else \
            INF
        if current_distance_squared < closest_distance_squared:
            closest_distance_squared = current_distance_squared
            closest_worker = worker
    return closest_worker


func on_worker_idleness_changed(worker: Worker) -> void:
    if !worker.get_is_active():
        if !idle_workers.has(worker):
            idle_workers[worker] = true
            _try_next_command()
    else:
        if idle_workers.has(worker):
            idle_workers.erase(worker)


func add_worker(worker_type: int) -> Worker:
    var worker_scene: PackedScene
    match worker_type:
        CommandType.SMALL_WORKER:
            worker_scene = _FRIENDLY_SMALL_WORKER_SCENE
        CommandType.MEDIUM_WORKER:
            worker_scene = _FRIENDLY_MEDIUM_WORKER_SCENE
        CommandType.LARGE_WORKER:
            worker_scene = _FRIENDLY_LARGE_WORKER_SCENE
        _:
            Sc.logger.error("GameLevel.add_worker")
            return null
    var worker: Worker = add_character(
            worker_scene,
            base.get_center(),
            true,
            false,
            true)
    worker.worker_type = worker_type
    
    workers.push_back(worker)
    
    session.workers_built_count += 1
    _update_session_counts()
    
    worker_spawn_controller.on_worker_added(worker)
    
    return worker


func remove_worker(worker: Worker) -> void:
    assert(workers.has(worker))
    
    if selected_friendly == worker:
        _clear_selection()
    
    workers.erase(worker)
    
    idle_workers.erase(worker)
    
    var commands_to_cancel := []
    for collection in [command_queue, in_progress_commands]:
        for command in collection:
            if command.worker == worker:
                commands_to_cancel.push_back(command)
    for command in commands_to_cancel:
        cancel_command(command)
    
    worker_spawn_controller.on_worker_removed(worker)
    
    _update_session_counts()
    remove_character(worker)


func add_enemy(
        enemy_type: int,
        upgrade_type: int,
        position: Vector2) -> Enemy:
    var enemy_scene: PackedScene
    match enemy_type:
        CommandType.ENEMY_SMALL:
            enemy_scene = _SMALL_ENEMY_SCENE
        CommandType.ENEMY_LARGE:
            enemy_scene = _LARGE_ENEMY_SCENE
        _:
            Sc.logger.error("GameLevel.add_enemy")
            return null
    var enemy: Enemy = add_character(
        enemy_scene,
        position,
        true,
        false,
        false)
    enemy.set_upgrade_type(upgrade_type)
    add_child(enemy)
    
    enemies.push_back(enemy)
    
    session.enemies_built_count += 1
    _update_session_counts()
    
    enemy_spawn_controller.on_enemy_added(enemy)
    
    return enemy


func remove_enemy(enemy: Enemy) -> void:
    assert(enemies.has(enemy))
    
    if selected_enemy == enemy:
        _clear_selection()
    
    enemies.erase(enemy)
    
    enemy_spawn_controller.on_enemy_removed(enemy)
    
    _update_session_counts()
    remove_character(enemy)


func add_projectile(
        projectile_type: int,
        position: Vector2,
        velocity: Vector2) -> Projectile:
    var projectile_scene: PackedScene
    match projectile_type:
        Projectile.FRIENDLY:
            projectile_scene = _FRIENDLY_PROJECTILE_SCENE
        Projectile.SMALL_ENEMY:
            projectile_scene = _SMALL_ENEMY_PROJECTILE_SCENE
        Projectile.LARGE_ENEMY:
            projectile_scene = _LARGE_ENEMY_PROJECTILE_SCENE
        _:
            Sc.logger.error("GameLevel.add_projectile")
            return null
    
    var projectile: Projectile = projectile_scene.instance()
    projectile.position = position
    projectile.velocity = velocity
    
    projectiles.push_back(projectile)
    
    session.projectiles_built_count += 1
    _update_session_counts()
    
    projectile_controller.on_projectile_added(projectile)
    
    return projectile


func remove_projectile(projectile: Projectile) -> void:
    assert(projectiles.has(projectile))
    projectiles.erase(projectile)
    projectile_controller.on_projectile_removed(projectile)
    _update_session_counts()
    projectile._destroy()


func remove_hero(hero: Hero) -> void:
    remove_character(hero)


func replace_building(
        old_building: Building,
        new_building_type: int) -> void:
    var building_position := old_building.position
    remove_building(old_building)
    var building_scene: PackedScene
    match new_building_type:
        CommandType.BUILDING_EMPTY:
            building_scene = _EMPTY_STRUCTURE_SCENE
        CommandType.SMALL_BASE:
            building_scene = _SMALL_BASE_SCENE
        CommandType.MEDIUM_BASE:
            building_scene = _MEDIUM_BASE_SCENE
        CommandType.LARGE_BASE:
            building_scene = _LARGE_BASE_SCENE
        CommandType.SMALL_TOWER:
            building_scene = _SMALL_TOWER_SCENE
        CommandType.MEDIUM_TOWER:
            building_scene = _MEDIUM_TOWER_SCENE
        CommandType.LARGE_TOWER:
            building_scene = _LARGE_TOWER_SCENE
        CommandType.SMALL_FARM:
            building_scene = _SMALL_FARM_SCENE
        CommandType.MEDIUM_FARM:
            building_scene = _MEDIUM_FARM_SCENE
        CommandType.LARGE_FARM:
            building_scene = _LARGE_FARM_SCENE
        _:
            Sc.logger.error("GameLevel.replace_building")
    var new_building := building_scene.instance()
    new_building.position = building_position
    $Buildings.add_child(new_building)
    _on_building_created(new_building)


func remove_building(building: Building) -> void:
    if is_instance_valid(building.occupying_worker):
        building.occupying_worker._on_vacated_building()
    
    assert(buildings.has(building))
    buildings.erase(building)
    if building is EmptyStructure:
        assert(empty_structures.has(building))
        empty_structures.erase(building)
    if building is EnemySpawn:
        assert(enemy_spawn_points.has(building))
        enemy_spawn_points.erase(building)
    
    var commands_to_cancel := []
    for collection in [command_queue, in_progress_commands]:
        for command in collection:
            if command.target_building == building or \
                    command.next_target_building == building:
                commands_to_cancel.push_back(command)
    for command in commands_to_cancel:
        cancel_command(command)
    
    building._destroy()
    _update_session_counts()


func _on_building_created(
        building: Building,
        is_default_building := false) -> void:
    if !is_default_building and !(building is EmptyStructure):
        session.buildings_built_count += 1
    buildings.push_back(building)
    if building is EmptyStructure:
        empty_structures.push_back(building)
    if building is EnemySpawn:
        enemy_spawn_points.push_back(building)
    _update_session_counts()


func on_building_health_depleted(building: Building) -> void:
    # FIXME: ------------------------ Play sound.
#    Sc.annotators.add_transient(
#        BuildingExplosionAnnotator.new(building.get_center()))
    var is_base := building is Base
    replace_building(building, CommandType.building_EMPTY)
    if is_base:
        quit(false, false)


func on_worker_health_depleted(worker: Worker) -> void:
    # FIXME: ------------------------ Play sound.
#    Sc.annotators.add_transient(WorkerExplosionAnnotator.new(worker.position))
    remove_worker(worker)


func on_hero_health_depleted(hero: Hero) -> void:
    # FIXME: ------------------------ Play sound.
#    Sc.annotators.add_transient(WorkerExplosionAnnotator.new(worker.position))
    remove_hero(hero)
    quit(false, false)


func on_enemy_health_depleted(enemy: Enemy) -> void:
    # FIXME: ------------------------ Play sound.
#    Sc.annotators.add_transient(WorkerExplosionAnnotator.new(worker.position))
    remove_enemy(enemy)


func _update_session_counts() -> void:
    session.worker_count = workers.size()
    session.enemy_count = enemies.size()
    session.building_count = \
        buildings.size() - empty_structures.size() - enemy_spawn_points.size()
    session.current_enemy_spawn_point_count = enemy_spawn_points.size()
    
    update_command_enablement()


func get_music_name() -> String:
    # FIXME: -------------------
    return "on_a_quest"


func get_slow_motion_music_name() -> String:
    # FIXME: Add slo-mo music
    return ""
