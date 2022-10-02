class_name ProjectileSpeeds
extends Reference


const SPEED_FRIENDLY_MINOR := 1200.0
const SPEED_FRIENDLY_MODERATE := SPEED_FRIENDLY_MINOR * 1.15
const SPEED_FRIENDLY_MAJOR := SPEED_FRIENDLY_MODERATE * 1.15

const SPEED_SMALL_ENEMY_MINOR := SPEED_FRIENDLY_MINOR * 0.9
const SPEED_SMALL_ENEMY_MODERATE := SPEED_SMALL_ENEMY_MINOR * 1.05
const SPEED_SMALL_ENEMY_MAJOR := SPEED_SMALL_ENEMY_MINOR * 1.05

const SPEED_LARGE_ENEMY_MINOR := SPEED_SMALL_ENEMY_MINOR * 1.0
const SPEED_LARGE_ENEMY_MODERATE := SPEED_SMALL_ENEMY_MINOR * 1.05
const SPEED_LARGE_ENEMY_MAJOR := SPEED_SMALL_ENEMY_MINOR * 1.05

const SPEED_MINOR_TOWER_MULTIPLIER := 1.1
const SPEED_MODERATE_TOWER_MULTIPLIER := 1.3
const SPEED_MAJOR_TOWER_MULTIPLIER := 1.5

const INTERVAL_FRIENDLY_MINOR := 2.0
const INTERVAL_FRIENDLY_MODERATE := INTERVAL_FRIENDLY_MINOR * 0.95
const INTERVAL_FRIENDLY_MAJOR := INTERVAL_FRIENDLY_MODERATE * 0.9

const INTERVAL_SMALL_ENEMY_MINOR := INTERVAL_FRIENDLY_MINOR * 1.1
const INTERVAL_SMALL_ENEMY_MODERATE := INTERVAL_SMALL_ENEMY_MINOR * 0.95
const INTERVAL_SMALL_ENEMY_MAJOR := INTERVAL_SMALL_ENEMY_MINOR * 0.9

const INTERVAL_LARGE_ENEMY_MINOR := INTERVAL_SMALL_ENEMY_MINOR * 1.4
const INTERVAL_LARGE_ENEMY_MODERATE := INTERVAL_SMALL_ENEMY_MINOR * 0.95
const INTERVAL_LARGE_ENEMY_MAJOR := INTERVAL_SMALL_ENEMY_MINOR * 0.9

const INTERVAL_MINOR_TOWER_MULTIPLIER := 0.95
const INTERVAL_MODERATE_TOWER_MULTIPLIER := 0.9
const INTERVAL_MAJOR_TOWER_MULTIPLIER := 0.85


static func get_speed(
        entity_type: int,
        upgrade_type: int,
        tower_upgrade_type := UpgradeType.UNKNOWN) -> float:
    var tower_multiplier: float
    match tower_upgrade_type:
        UpgradeType.UNKNOWN:
            tower_multiplier = 1.0
        UpgradeType.MINOR:
            tower_multiplier = SPEED_MINOR_TOWER_MULTIPLIER
        UpgradeType.MODERATE:
            tower_multiplier = SPEED_MODERATE_TOWER_MULTIPLIER
        UpgradeType.MAJOR:
            tower_multiplier = SPEED_MAJOR_TOWER_MULTIPLIER
        _:
            Sc.logger.error("ProjectileSpeeds.get_speed.tower_upgrade_type")
            return INF
    
    var speed: float
    match [entity_type, upgrade_type]:
        [CommandType.HERO, _]:
            speed = SPEED_FRIENDLY_MODERATE
        
        [CommandType.SMALL_WORKER, UpgradeType.MINOR]:
            speed = SPEED_FRIENDLY_MINOR
        [CommandType.SMALL_WORKER, UpgradeType.MODERATE]:
            speed = SPEED_FRIENDLY_MODERATE
        [CommandType.SMALL_WORKER, UpgradeType.MAJOR]:
            speed = SPEED_FRIENDLY_MAJOR
        
        [CommandType.ENEMY_SMALL, UpgradeType.MINOR]:
            speed = SPEED_SMALL_ENEMY_MINOR
        [CommandType.ENEMY_SMALL, UpgradeType.MODERATE]:
            speed = SPEED_SMALL_ENEMY_MODERATE
        [CommandType.ENEMY_SMALL, UpgradeType.MAJOR]:
            speed = SPEED_SMALL_ENEMY_MAJOR
        
        [CommandType.ENEMY_LARGE, UpgradeType.MINOR]:
            speed = SPEED_LARGE_ENEMY_MINOR
        [CommandType.ENEMY_LARGE, UpgradeType.MODERATE]:
            speed = SPEED_LARGE_ENEMY_MODERATE
        [CommandType.ENEMY_LARGE, UpgradeType.MAJOR]:
            speed = SPEED_LARGE_ENEMY_MAJOR
        
        _:
            Sc.logger.error(
                "ProjectileSpeeds.get_speed[entity_type, upgrade_type]")
            return INF
    
    return speed * tower_multiplier


static func get_interval(
        entity_type: int,
        upgrade_type: int,
        tower_upgrade_type := UpgradeType.UNKNOWN) -> float:
    var tower_multiplier: float
    match tower_upgrade_type:
        UpgradeType.UNKNOWN:
            tower_multiplier = 1.0
        UpgradeType.MINOR:
            tower_multiplier = INTERVAL_MINOR_TOWER_MULTIPLIER
        UpgradeType.MODERATE:
            tower_multiplier = INTERVAL_MODERATE_TOWER_MULTIPLIER
        UpgradeType.MAJOR:
            tower_multiplier = INTERVAL_MAJOR_TOWER_MULTIPLIER
        _:
            Sc.logger.error("ProjectileSpeeds.get_speed.tower_upgrade_type")
            return INF
    
    var speed: float
    match [entity_type, upgrade_type]:
        [CommandType.HERO, _]:
            speed = INTERVAL_FRIENDLY_MODERATE
        
        [CommandType.SMALL_WORKER, UpgradeType.MINOR]:
            speed = INTERVAL_FRIENDLY_MINOR
        [CommandType.SMALL_WORKER, UpgradeType.MODERATE]:
            speed = INTERVAL_FRIENDLY_MODERATE
        [CommandType.SMALL_WORKER, UpgradeType.MAJOR]:
            speed = INTERVAL_FRIENDLY_MAJOR
        
        [CommandType.ENEMY_SMALL, UpgradeType.MINOR]:
            speed = INTERVAL_SMALL_ENEMY_MINOR
        [CommandType.ENEMY_SMALL, UpgradeType.MODERATE]:
            speed = INTERVAL_SMALL_ENEMY_MODERATE
        [CommandType.ENEMY_SMALL, UpgradeType.MAJOR]:
            speed = INTERVAL_SMALL_ENEMY_MAJOR
        
        [CommandType.ENEMY_LARGE, UpgradeType.MINOR]:
            speed = INTERVAL_LARGE_ENEMY_MINOR
        [CommandType.ENEMY_LARGE, UpgradeType.MODERATE]:
            speed = INTERVAL_LARGE_ENEMY_MODERATE
        [CommandType.ENEMY_LARGE, UpgradeType.MAJOR]:
            speed = INTERVAL_LARGE_ENEMY_MAJOR
        
        _:
            Sc.logger.error(
                "ProjectileSpeeds.get_interval[entity_type, upgrade_type]")
            return INF
    
    return speed * tower_multiplier
