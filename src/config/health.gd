class_name Health
extends Reference


const HERO := 1000

const SMALL_WORKER := 300
const MEDIUM_WORKER := 1600
const LARGE_WORKER := 3200

const BUILDING_EMPTY := -1

const SMALL_BASE := 1500
const MEDIUM_BASE := 4000
const LARGE_BASE := 8000

const SMALL_TOWER := 100
const MEDIUM_TOWER := 2000
const LARGE_TOWER := 4000

const SMALL_FARM := 800
const MEDIUM_FARM := 1600
const LARGE_FARM := 3200

const BUILDING_ENEMY_SPAWN := 1400
const ENEMY_SMALL := 110
const ENEMY_LARGE := 520


static func get_default_capacity(entity_command_type: int) -> int:
    match entity_command_type:
        CommandType.HERO:
            return HERO
        
        CommandType.SMALL_WORKER:
            return SMALL_WORKER
        CommandType.MEDIUM_WORKER:
            return MEDIUM_WORKER
        CommandType.LARGE_WORKER:
            return LARGE_WORKER
        
        CommandType.BUILDING_EMPTY:
            return BUILDING_EMPTY
        
        CommandType.SMALL_BASE:
            return SMALL_BASE
        CommandType.MEDIUM_BASE:
            return MEDIUM_BASE
        CommandType.LARGE_BASE:
            return LARGE_BASE
        
        CommandType.SMALL_TOWER:
            return SMALL_TOWER
        CommandType.MEDIUM_TOWER:
            return MEDIUM_TOWER
        CommandType.LARGE_TOWER:
            return LARGE_TOWER
        
        CommandType.SMALL_FARM:
            return SMALL_FARM
        CommandType.MEDIUM_FARM:
            return MEDIUM_FARM
        CommandType.LARGE_FARM:
            return LARGE_FARM
        
        CommandType.BUILDING_ENEMY_SPAWN:
            return BUILDING_ENEMY_SPAWN
        CommandType.ENEMY_SMALL:
            return ENEMY_SMALL
        CommandType.ENEMY_LARGE:
            return ENEMY_LARGE
        
        _:
            Sc.logger.error("Health.get_default_capacity")
            return -1
