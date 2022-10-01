class_name Health
extends Reference


const HERO := 1000

const SMALL_WORKER := 200
const MEDIUM_WORKER := 800
const LARGE_WORKER := 3200

const SMALL_ENEMY := 100
const LARGE_ENEMY := 800

const SMALL_TOWER := 2000
const MEDIUM_TOWER := 8000
const LARGE_TOWER := 32000

const SMALL_FARM := 800
const MEDIUM_FARM := 3200
const LARGE_FARM := 12800


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

        CommandType.SMALL_ENEMY:
            return SMALL_ENEMY
        CommandType.LARGE_ENEMY:
            return LARGE_ENEMY

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
        
        _:
            Sc.logger.error("Health.get_default_capacity")
            return -1
