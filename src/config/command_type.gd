class_name CommandType
extends Reference


enum {
    UNKNOWN,
    
    FRIENDLY_SMALL_UPGRADE,
    FRIENDLY_MEDIUM_UPGRADE,
    
    FRIENDLY_RALLY,
    FRIENDLY_MOVE,
    FRIENDLY_STOP,
    FRIENDLY_INFO,
    
    BUILDING_EMPTY,
    BUILDING_BASE,
    BUILDING_TOWER,
    BUILDING_FARM,
    
    BUILDING_BASE_SMALL_UPGRADE,
    BUILDING_BASE_MEDIUM_UPGRADE,
    BUILDING_TOWER_SMALL_UPGRADE,
    BUILDING_TOWER_MEDIUM_UPGRADE,
    BUILDING_FARM_SMALL_UPGRADE,
    BUILDING_FARM_MEDIUM_UPGRADE,
    
    BUILDING_OCCUPY,
    BUILDING_VACATE,
    BUILDING_RECYCLE,
    BUILDING_STOP,
    BUILDING_INFO,
    
    # FIXME: These are actually entity_types, not command_types, and should be pulled out.
    
    HERO,
    
    SMALL_WORKER,
    MEDIUM_WORKER,
    LARGE_WORKER,
    
    SMALL_BASE,
    MEDIUM_BASE,
    LARGE_BASE,
    
    SMALL_TOWER,
    MEDIUM_TOWER,
    LARGE_TOWER,
    
    SMALL_FARM,
    MEDIUM_FARM,
    LARGE_FARM,
    
    BUILDING_ENEMY_SPAWN,
    ENEMY_SMALL,
    ENEMY_LARGE,
}

const VALUES := [
    UNKNOWN,
    
    FRIENDLY_SMALL_UPGRADE,
    FRIENDLY_MEDIUM_UPGRADE,
    
    FRIENDLY_RALLY,
    FRIENDLY_MOVE,
    FRIENDLY_STOP,
    FRIENDLY_INFO,
    
    BUILDING_EMPTY,
    BUILDING_BASE,
    BUILDING_TOWER,
    BUILDING_FARM,
    
    BUILDING_BASE_SMALL_UPGRADE,
    BUILDING_BASE_MEDIUM_UPGRADE,
    BUILDING_TOWER_SMALL_UPGRADE,
    BUILDING_TOWER_MEDIUM_UPGRADE,
    BUILDING_FARM_SMALL_UPGRADE,
    BUILDING_FARM_MEDIUM_UPGRADE,
    
    BUILDING_OCCUPY,
    BUILDING_VACATE,
    BUILDING_RECYCLE,
    BUILDING_STOP,
    BUILDING_INFO,
    
    HERO,
    
    SMALL_WORKER,
    MEDIUM_WORKER,
    LARGE_WORKER,
    
    SMALL_BASE,
    MEDIUM_BASE,
    LARGE_BASE,
    
    SMALL_TOWER,
    MEDIUM_TOWER,
    LARGE_TOWER,
    
    SMALL_FARM,
    MEDIUM_FARM,
    LARGE_FARM,

    BUILDING_ENEMY_SPAWN,
    ENEMY_SMALL,
    ENEMY_LARGE,
]

const COSTS := {
    UNKNOWN: INF,
    
    FRIENDLY_SMALL_UPGRADE: Cost.FRIENDLY_SMALL_UPGRADE,
    FRIENDLY_MEDIUM_UPGRADE: Cost.FRIENDLY_MEDIUM_UPGRADE,
    FRIENDLY_RALLY: Cost.FRIENDLY_RALLY,
    FRIENDLY_MOVE: Cost.FRIENDLY_MOVE,
    FRIENDLY_STOP: Cost.FRIENDLY_STOP,
    FRIENDLY_INFO: Cost.FRIENDLY_INFO,
    
    BUILDING_EMPTY: Cost.BUILDING_EMPTY,
    BUILDING_BASE: Cost.BUILDING_BASE,
    BUILDING_TOWER: Cost.BUILDING_TOWER,
    BUILDING_FARM: Cost.BUILDING_FARM,
    
    BUILDING_BASE_SMALL_UPGRADE: Cost.BUILDING_BASE_SMALL_UPGRADE,
    BUILDING_BASE_MEDIUM_UPGRADE: Cost.BUILDING_BASE_MEDIUM_UPGRADE,
    BUILDING_TOWER_SMALL_UPGRADE: Cost.BUILDING_TOWER_SMALL_UPGRADE,
    BUILDING_TOWER_MEDIUM_UPGRADE: Cost.BUILDING_TOWER_MEDIUM_UPGRADE,
    BUILDING_FARM_SMALL_UPGRADE: Cost.BUILDING_FARM_SMALL_UPGRADE,
    BUILDING_FARM_MEDIUM_UPGRADE: Cost.BUILDING_FARM_MEDIUM_UPGRADE,
    
    BUILDING_OCCUPY: Cost.BUILDING_OCCUPY,
    BUILDING_VACATE: Cost.BUILDING_VACATE,
    BUILDING_RECYCLE: Cost.BUILDING_RECYCLE,
    BUILDING_STOP: Cost.BUILDING_STOP,
    BUILDING_INFO: Cost.BUILDING_INFO,
    
    HERO: Cost.HERO,
    
    SMALL_WORKER: Cost.SMALL_WORKER,
    MEDIUM_WORKER: Cost.MEDIUM_WORKER,
    LARGE_WORKER: Cost.LARGE_WORKER,
    
    SMALL_BASE: Cost.SMALL_BASE,
    MEDIUM_BASE: Cost.MEDIUM_BASE,
    LARGE_BASE: Cost.LARGE_BASE,
    
    SMALL_TOWER: Cost.SMALL_TOWER,
    MEDIUM_TOWER: Cost.MEDIUM_TOWER,
    LARGE_TOWER: Cost.LARGE_TOWER,
    
    SMALL_FARM: Cost.SMALL_FARM,
    MEDIUM_FARM: Cost.MEDIUM_FARM,
    LARGE_FARM: Cost.LARGE_FARM,
    
    BUILDING_ENEMY_SPAWN: Cost.BUILDING_ENEMY_SPAWN,
    ENEMY_SMALL: Cost.ENEMY_SMALL,
    ENEMY_LARGE: Cost.ENEMY_LARGE,
}

const ENTITY_NAMES := {
    HERO: Description.ENTITY_NAMES.HERO,
    
    SMALL_WORKER: Description.ENTITY_NAMES.SMALL_WORKER,
    MEDIUM_WORKER: Description.ENTITY_NAMES.MEDIUM_WORKER,
    LARGE_WORKER: Description.ENTITY_NAMES.LARGE_WORKER,
    
    BUILDING_EMPTY: Description.ENTITY_NAMES.BUILDING_EMPTY,
    
    SMALL_BASE: Description.ENTITY_NAMES.SMALL_BASE,
    MEDIUM_BASE: Description.ENTITY_NAMES.MEDIUM_BASE,
    LARGE_BASE: Description.ENTITY_NAMES.LARGE_BASE,
    
    SMALL_TOWER: Description.ENTITY_NAMES.SMALL_TOWER,
    MEDIUM_TOWER: Description.ENTITY_NAMES.MEDIUM_TOWER,
    LARGE_TOWER: Description.ENTITY_NAMES.LARGE_TOWER,
    
    SMALL_FARM: Description.ENTITY_NAMES.SMALL_FARM,
    MEDIUM_FARM: Description.ENTITY_NAMES.MEDIUM_FARM,
    LARGE_FARM: Description.ENTITY_NAMES.LARGE_FARM,

    BUILDING_ENEMY_SPAWN: Description.ENTITY_NAMES.BUILDING_ENEMY_SPAWN,
    ENEMY_SMALL: Description.ENTITY_NAMES.ENEMY_SMALL,
    ENEMY_LARGE: Description.ENTITY_NAMES.ENEMY_LARGE,
}

const ENTITY_DESCRIPTIONS := {
    HERO: Description.ENTITY_DESCRIPTIONS.HERO,
    
    SMALL_WORKER: Description.ENTITY_DESCRIPTIONS.SMALL_WORKER,
    MEDIUM_WORKER: Description.ENTITY_DESCRIPTIONS.MEDIUM_WORKER,
    LARGE_WORKER: Description.ENTITY_DESCRIPTIONS.LARGE_WORKER,
    
    BUILDING_EMPTY: Description.ENTITY_DESCRIPTIONS.BUILDING_EMPTY,
    
    SMALL_BASE: Description.ENTITY_DESCRIPTIONS.SMALL_BASE,
    MEDIUM_BASE: Description.ENTITY_DESCRIPTIONS.MEDIUM_BASE,
    LARGE_BASE: Description.ENTITY_DESCRIPTIONS.LARGE_BASE,
    
    SMALL_TOWER: Description.ENTITY_DESCRIPTIONS.SMALL_TOWER,
    MEDIUM_TOWER: Description.ENTITY_DESCRIPTIONS.MEDIUM_TOWER,
    LARGE_TOWER: Description.ENTITY_DESCRIPTIONS.LARGE_TOWER,
    
    SMALL_FARM: Description.ENTITY_DESCRIPTIONS.SMALL_FARM,
    MEDIUM_FARM: Description.ENTITY_DESCRIPTIONS.MEDIUM_FARM,
    LARGE_FARM: Description.ENTITY_DESCRIPTIONS.LARGE_FARM,

    BUILDING_ENEMY_SPAWN: Description.ENTITY_DESCRIPTIONS.BUILDING_ENEMY_SPAWN,
    ENEMY_SMALL: Description.ENTITY_DESCRIPTIONS.ENEMY_SMALL,
    ENEMY_LARGE: Description.ENTITY_DESCRIPTIONS.ENEMY_LARGE,
}

const COMMAND_LABELS := {
    UNKNOWN: "",
    
    FRIENDLY_SMALL_UPGRADE: Description.COMMAND_LABELS.FRIENDLY_SMALL_UPGRADE,
    FRIENDLY_MEDIUM_UPGRADE: Description.COMMAND_LABELS.FRIENDLY_MEDIUM_UPGRADE,
    
    FRIENDLY_RALLY: Description.COMMAND_LABELS.FRIENDLY_RALLY,
    FRIENDLY_MOVE: Description.COMMAND_LABELS.FRIENDLY_MOVE,
    FRIENDLY_STOP: Description.COMMAND_LABELS.FRIENDLY_STOP,
    FRIENDLY_INFO: Description.COMMAND_LABELS.FRIENDLY_INFO,
    
    BUILDING_EMPTY: Description.COMMAND_LABELS.BUILDING_EMPTY,
    BUILDING_BASE: Description.COMMAND_LABELS.BUILDING_BASE,
    BUILDING_TOWER: Description.COMMAND_LABELS.BUILDING_TOWER,
    BUILDING_FARM: Description.COMMAND_LABELS.BUILDING_FARM,
    
    BUILDING_BASE_SMALL_UPGRADE: Description.COMMAND_LABELS.BUILDING_BASE_UPGRADE,
    BUILDING_BASE_MEDIUM_UPGRADE: Description.COMMAND_LABELS.BUILDING_BASE_UPGRADE,
    BUILDING_TOWER_SMALL_UPGRADE: Description.COMMAND_LABELS.BUILDING_TOWER_UPGRADE,
    BUILDING_TOWER_MEDIUM_UPGRADE: Description.COMMAND_LABELS.BUILDING_TOWER_UPGRADE,
    BUILDING_FARM_SMALL_UPGRADE: Description.COMMAND_LABELS.BUILDING_FARM_UPGRADE,
    BUILDING_FARM_MEDIUM_UPGRADE: Description.COMMAND_LABELS.BUILDING_FARM_UPGRADE,
    
    BUILDING_OCCUPY: Description.COMMAND_LABELS.BUILDING_OCCUPY,
    BUILDING_VACATE: Description.COMMAND_LABELS.BUILDING_VACATE,
    BUILDING_RECYCLE: Description.COMMAND_LABELS.BUILDING_RECYCLE,
    BUILDING_STOP: Description.COMMAND_LABELS.BUILDING_STOP,
    BUILDING_INFO: Description.COMMAND_LABELS.BUILDING_INFO,
    
#    HERO: Description.COMMAND_LABELS.HERO,
#
#    SMALL_WORKER: Description.COMMAND_LABELS.SMALL_WORKER,
#    MEDIUM_WORKER: Description.COMMAND_LABELS.MEDIUM_WORKER,
#    LARGE_WORKER: Description.COMMAND_LABELS.LARGE_WORKER,
    
    SMALL_BASE: Description.COMMAND_LABELS.SMALL_BASE,
    MEDIUM_BASE: Description.COMMAND_LABELS.MEDIUM_BASE,
    LARGE_BASE: Description.COMMAND_LABELS.LARGE_BASE,

    SMALL_TOWER: Description.COMMAND_LABELS.SMALL_TOWER,
    MEDIUM_TOWER: Description.COMMAND_LABELS.MEDIUM_TOWER,
    LARGE_TOWER: Description.COMMAND_LABELS.LARGE_TOWER,

    SMALL_FARM: Description.COMMAND_LABELS.SMALL_FARM,
    MEDIUM_FARM: Description.COMMAND_LABELS.MEDIUM_FARM,
    LARGE_FARM: Description.COMMAND_LABELS.LARGE_FARM,

    BUILDING_ENEMY_SPAWN: Description.COMMAND_LABELS.BUILDING_ENEMY_SPAWN,
    ENEMY_SMALL: Description.COMMAND_LABELS.ENEMY_SMALL,
    ENEMY_LARGE: Description.COMMAND_LABELS.ENEMY_LARGE,
}

const COMMAND_DESCRIPTIONS := {
    UNKNOWN: "",
    
    FRIENDLY_SMALL_UPGRADE: Description.COMMAND_DESCRIPTIONS.FRIENDLY_SMALL_UPGRADE,
    FRIENDLY_MEDIUM_UPGRADE: Description.COMMAND_DESCRIPTIONS.FRIENDLY_MEDIUM_UPGRADE,
    
    FRIENDLY_RALLY: Description.COMMAND_DESCRIPTIONS.FRIENDLY_RALLY,
    FRIENDLY_MOVE: Description.COMMAND_DESCRIPTIONS.FRIENDLY_MOVE,
    FRIENDLY_STOP: Description.COMMAND_DESCRIPTIONS.FRIENDLY_STOP,
    FRIENDLY_INFO: Description.COMMAND_DESCRIPTIONS.FRIENDLY_INFO,
    
    BUILDING_BASE: Description.COMMAND_DESCRIPTIONS.BUILDING_BASE,
    BUILDING_TOWER: Description.COMMAND_DESCRIPTIONS.BUILDING_TOWER,
    BUILDING_FARM: Description.COMMAND_DESCRIPTIONS.BUILDING_FARM,
    
    BUILDING_BASE_SMALL_UPGRADE: Description.COMMAND_DESCRIPTIONS.BUILDING_BASE_UPGRADE,
    BUILDING_BASE_MEDIUM_UPGRADE: Description.COMMAND_DESCRIPTIONS.BUILDING_BASE_UPGRADE,
    BUILDING_TOWER_SMALL_UPGRADE: Description.COMMAND_DESCRIPTIONS.BUILDING_TOWER_UPGRADE,
    BUILDING_TOWER_MEDIUM_UPGRADE: Description.COMMAND_DESCRIPTIONS.BUILDING_TOWER_UPGRADE,
    BUILDING_FARM_SMALL_UPGRADE: Description.COMMAND_DESCRIPTIONS.BUILDING_FARM_UPGRADE,
    BUILDING_FARM_MEDIUM_UPGRADE: Description.COMMAND_DESCRIPTIONS.BUILDING_FARM_UPGRADE,
    
    BUILDING_OCCUPY: Description.COMMAND_DESCRIPTIONS.BUILDING_OCCUPY,
    BUILDING_VACATE: Description.COMMAND_DESCRIPTIONS.BUILDING_VACATE,
    BUILDING_RECYCLE: Description.COMMAND_DESCRIPTIONS.BUILDING_RECYCLE,
    BUILDING_STOP: Description.COMMAND_DESCRIPTIONS.BUILDING_STOP,
    BUILDING_INFO: Description.COMMAND_DESCRIPTIONS.BUILDING_INFO,
    
#    HERO: Description.COMMAND_DESCRIPTIONS.HERO,
#
#    SMALL_WORKER: Description.COMMAND_DESCRIPTIONS.SMALL_WORKER,
#    MEDIUM_WORKER: Description.COMMAND_DESCRIPTIONS.MEDIUM_WORKER,
#    LARGE_WORKER: Description.COMMAND_DESCRIPTIONS.LARGE_WORKER,
    
    SMALL_BASE: Description.COMMAND_DESCRIPTIONS.SMALL_BASE,
    MEDIUM_BASE: Description.COMMAND_DESCRIPTIONS.MEDIUM_BASE,
    LARGE_BASE: Description.COMMAND_DESCRIPTIONS.LARGE_BASE,

    SMALL_TOWER: Description.COMMAND_DESCRIPTIONS.SMALL_TOWER,
    MEDIUM_TOWER: Description.COMMAND_DESCRIPTIONS.MEDIUM_TOWER,
    LARGE_TOWER: Description.COMMAND_DESCRIPTIONS.LARGE_TOWER,

    SMALL_FARM: Description.COMMAND_DESCRIPTIONS.SMALL_FARM,
    MEDIUM_FARM: Description.COMMAND_DESCRIPTIONS.MEDIUM_FARM,
    LARGE_FARM: Description.COMMAND_DESCRIPTIONS.LARGE_FARM,

    BUILDING_ENEMY_SPAWN: Description.COMMAND_DESCRIPTIONS.BUILDING_ENEMY_SPAWN,
    ENEMY_SMALL: Description.COMMAND_DESCRIPTIONS.ENEMY_SMALL,
    ENEMY_LARGE: Description.COMMAND_DESCRIPTIONS.ENEMY_LARGE,
}

const TEXTURES := {
    UNKNOWN: null,
    
    FRIENDLY_SMALL_UPGRADE: preload("res://assets/images/gui/overlay_buttons/upgrade_overlay_button.png"),
    FRIENDLY_MEDIUM_UPGRADE: preload("res://assets/images/gui/overlay_buttons/upgrade_overlay_button.png"),
    FRIENDLY_RALLY: preload("res://assets/images/gui/overlay_buttons/destroy_overlay_button.png"),
    FRIENDLY_MOVE: preload("res://assets/images/gui/overlay_buttons/destroy_overlay_button.png"),
    FRIENDLY_STOP: preload("res://assets/images/gui/overlay_buttons/stop_overlay_button.png"),
    FRIENDLY_INFO: preload("res://assets/images/gui/overlay_buttons/info_overlay_button.png"),
    
    BUILDING_EMPTY: preload("res://assets/images/gui/overlay_buttons/destroy_overlay_button.png"),
    BUILDING_BASE: preload("res://assets/images/gui/overlay_buttons/destroy_overlay_button.png"),
    BUILDING_TOWER: preload("res://assets/images/gui/overlay_buttons/destroy_overlay_button.png"),
    BUILDING_FARM: preload("res://assets/images/gui/overlay_buttons/destroy_overlay_button.png"),
    
    BUILDING_BASE_SMALL_UPGRADE: preload("res://assets/images/gui/overlay_buttons/upgrade_overlay_button.png"),
    BUILDING_BASE_MEDIUM_UPGRADE: preload("res://assets/images/gui/overlay_buttons/upgrade_overlay_button.png"),
    BUILDING_TOWER_SMALL_UPGRADE: preload("res://assets/images/gui/overlay_buttons/upgrade_overlay_button.png"),
    BUILDING_TOWER_MEDIUM_UPGRADE: preload("res://assets/images/gui/overlay_buttons/upgrade_overlay_button.png"),
    BUILDING_FARM_SMALL_UPGRADE: preload("res://assets/images/gui/overlay_buttons/upgrade_overlay_button.png"),
    BUILDING_FARM_MEDIUM_UPGRADE: preload("res://assets/images/gui/overlay_buttons/upgrade_overlay_button.png"),
    
    BUILDING_OCCUPY: preload("res://assets/images/gui/overlay_buttons/destroy_overlay_button.png"),
    BUILDING_VACATE: preload("res://assets/images/gui/overlay_buttons/destroy_overlay_button.png"),
    BUILDING_RECYCLE: preload("res://assets/images/gui/overlay_buttons/destroy_overlay_button.png"),
    BUILDING_STOP: preload("res://assets/images/gui/overlay_buttons/stop_overlay_button.png"),
    BUILDING_INFO: preload("res://assets/images/gui/overlay_buttons/info_overlay_button.png"),
    
    HERO: preload("res://assets/images/gui/overlay_buttons/destroy_overlay_button.png"),
    
    SMALL_WORKER: preload("res://assets/images/gui/overlay_buttons/destroy_overlay_button.png"),
    MEDIUM_WORKER: preload("res://assets/images/gui/overlay_buttons/upgrade_overlay_button.png"),
    LARGE_WORKER: preload("res://assets/images/gui/overlay_buttons/upgrade_overlay_button.png"),
    
    SMALL_BASE: preload("res://assets/images/gui/overlay_buttons/destroy_overlay_button.png"),
    MEDIUM_BASE: preload("res://assets/images/gui/overlay_buttons/upgrade_overlay_button.png"),
    LARGE_BASE: preload("res://assets/images/gui/overlay_buttons/upgrade_overlay_button.png"),
    
    SMALL_TOWER: preload("res://assets/images/gui/overlay_buttons/tower_overlay_button.png"),
    MEDIUM_TOWER: preload("res://assets/images/gui/overlay_buttons/upgrade_overlay_button.png"),
    LARGE_TOWER: preload("res://assets/images/gui/overlay_buttons/upgrade_overlay_button.png"),
    
    SMALL_FARM: preload("res://assets/images/gui/overlay_buttons/destroy_overlay_button.png"),
    MEDIUM_FARM: preload("res://assets/images/gui/overlay_buttons/upgrade_overlay_button.png"),
    LARGE_FARM: preload("res://assets/images/gui/overlay_buttons/upgrade_overlay_button.png"),
    
    BUILDING_ENEMY_SPAWN: preload("res://assets/images/gui/overlay_buttons/destroy_overlay_button.png"),
    ENEMY_SMALL: preload("res://assets/images/gui/overlay_buttons/destroy_overlay_button.png"),
    ENEMY_LARGE: preload("res://assets/images/gui/overlay_buttons/destroy_overlay_button.png"),
}


static func get_string(type: int) -> String:
    match type:
        UNKNOWN:
            return "UNKNOWN"
        
        FRIENDLY_SMALL_UPGRADE:
            return "FRIENDLY_SMALL_UPGRADE"
        FRIENDLY_MEDIUM_UPGRADE:
            return "FRIENDLY_MEDIUM_UPGRADE"
        FRIENDLY_RALLY:
            return "FRIENDLY_RALLY"
        FRIENDLY_MOVE:
            return "FRIENDLY_MOVE"
        FRIENDLY_STOP:
            return "FRIENDLY_STOP"
        FRIENDLY_INFO:
            return "FRIENDLY_INFO"
        
        BUILDING_BASE:
            return "BUILDING_BASE"
        BUILDING_TOWER:
            return "BUILDING_TOWER"
        BUILDING_FARM:
            return "BUILDING_FARM"
            
        BUILDING_BASE_SMALL_UPGRADE:
            return "BUILDING_BASE_SMALL_UPGRADE"
        BUILDING_BASE_MEDIUM_UPGRADE:
            return "BUILDING_BASE_MEDIUM_UPGRADE"
        BUILDING_TOWER_SMALL_UPGRADE:
            return "BUILDING_TOWER_SMALL_UPGRADE"
        BUILDING_TOWER_MEDIUM_UPGRADE:
            return "BUILDING_TOWER_MEDIUM_UPGRADE"
        BUILDING_FARM_SMALL_UPGRADE:
            return "BUILDING_FARM_SMALL_UPGRADE"
        BUILDING_FARM_MEDIUM_UPGRADE:
            return "BUILDING_FARM_MEDIUM_UPGRADE"
        
        BUILDING_OCCUPY:
            return "BUILDING_OCCUPY"
        BUILDING_VACATE:
            return "BUILDING_VACATE"
        BUILDING_RECYCLE:
            return "BUILDING_RECYCLE"
        BUILDING_STOP:
            return "BUILDING_STOP"
        BUILDING_INFO:
            return "BUILDING_INFO"
        
        HERO:
            return "HERO"
        
        SMALL_WORKER:
            return "SMALL_WORKER"
        MEDIUM_WORKER:
            return "MEDIUM_WORKER"
        LARGE_WORKER:
            return "LARGE_WORKER"
        
        SMALL_BASE:
            return "SMALL_BASE"
        MEDIUM_BASE:
            return "MEDIUM_BASE"
        LARGE_BASE:
            return "LARGE_BASE"
        
        SMALL_TOWER:
            return "SMALL_TOWER"
        MEDIUM_TOWER:
            return "MEDIUM_TOWER"
        LARGE_TOWER:
            return "LARGE_TOWER"
        
        SMALL_FARM:
            return "SMALL_FARM"
        MEDIUM_FARM:
            return "MEDIUM_FARM"
        LARGE_FARM:
            return "LARGE_FARM"
        
        BUILDING_ENEMY_SPAWN:
            return "BUILDING_ENEMY_SPAWN"
        ENEMY_SMALL:
            return "ENEMY_SMALL"
        ENEMY_LARGE:
            return "ENEMY_LARGE"
        
        _:
            Sc.logger.error("CommandType.get_string: %s" % str(type))
            return ""
