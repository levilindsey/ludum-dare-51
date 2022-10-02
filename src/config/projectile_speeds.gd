class_name ProjectileSpeeds
extends Reference


enum {
    UNKNOWN,
    
    FRIENDLY_MINOR,
    FRIENDLY_MODERATE,
    FRIENDLY_MAJOR,
    
    SMALL_ENEMY_MINOR,
    SMALL_ENEMY_MODERATE,
    SMALL_ENEMY_MAJOR,
    
    LARGE_ENEMY_MINOR,
    LARGE_ENEMY_MODERATE,
    LARGE_ENEMY_MAJOR,
}

const MINOR_TOWER_MULTIPLIER := 1.1
const MODERATE_TOWER_MULTIPLIER := 1.3
const MAJOR_TOWER_MULTIPLIER := 1.5


static func get_speed(
        entity_type: int,
        upgrade_type: int,
        tower_upgrade_type := UpgradeType.UNKNOWN) -> float:
    var tower_multiplier: float
    match tower_upgrade_type:
        UpgradeType.UNKNOWN:
            tower_multiplier = 1.0
        UpgradeType.MINOR:
            tower_multiplier = MINOR_TOWER_MULTIPLIER
        UpgradeType.MODERATE:
            tower_multiplier = MODERATE_TOWER_MULTIPLIER
        UpgradeType.MAJOR:
            tower_multiplier = MAJOR_TOWER_MULTIPLIER
        _:
            Sc.logger.error("ProjectileSpeeds.get_speed.tower_upgrade_type")
            return INF
    
    var speed: float
    match [entity_type, upgrade_type]:
        [CommandType.SMALL_WORKER, UpgradeType.MINOR]:
            speed = FRIENDLY_MINOR
        [CommandType.SMALL_WORKER, UpgradeType.MODERATE]:
            speed = FRIENDLY_MODERATE
        [CommandType.SMALL_WORKER, UpgradeType.MAJOR]:
            speed = FRIENDLY_MAJOR
        
        [CommandType.ENEMY_SMALL, UpgradeType.MINOR]:
            speed = SMALL_ENEMY_MINOR
        [CommandType.ENEMY_SMALL, UpgradeType.MODERATE]:
            speed = SMALL_ENEMY_MODERATE
        [CommandType.ENEMY_SMALL, UpgradeType.MAJOR]:
            speed = SMALL_ENEMY_MAJOR
        
        [CommandType.ENEMY_LARGE, UpgradeType.MINOR]:
            speed = LARGE_ENEMY_MINOR
        [CommandType.ENEMY_LARGE, UpgradeType.MODERATE]:
            speed = LARGE_ENEMY_MODERATE
        [CommandType.ENEMY_LARGE, UpgradeType.MAJOR]:
            speed = LARGE_ENEMY_MAJOR
        
        _:
            Sc.logger.error(
                "ProjectileSpeeds.get_speed[entity_type, upgrade_type]")
            return INF
    
    return speed * tower_multiplier
