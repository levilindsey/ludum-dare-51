class_name Description
extends Reference


# Disablement messages.
const NOT_IMPLEMENTED := "Not implemented yet!"
const NOT_ENOUGH_MONEY := "Not enough money."
const MAX_WORKER_CAPACITY := "The max number of workers already exist."
const ALREADY_STOPPED := "Already stopped."
const ALREADY_BUILDING_CONSTRUCTION := "Already building a construction at this site."
const NEED_A_WORKER := "There is no worker to execute this command."

const LEVEL_SUCCESS_EXPLANATION := "You banished the monsters and protected the realm!"
const LEVEL_FAILURE_EXPLANATION := "You let the monsters ravage your village!"

const ENTITY_NAMES := {
    HERO = "Hero",
    
    SMALL_WORKER = "Average worker",
    MEDIUM_WORKER = "Strong worker",
    LARGE_WORKER = "Mighty worker",
    
    BUILDING_EMPTY = "Build site",
    
    SMALL_BASE = "Small base",
    MEDIUM_BASE = "Medium base",
    LARGE_BASE = "Large base",
    
    SMALL_TOWER = "Small guard tower",
    MEDIUM_TOWER = "Medium guard tower",
    LARGE_TOWER = "Large guard tower",
    
    SMALL_FARM = "Modest farm",
    MEDIUM_FARM = "Efficient farm",
    LARGE_FARM = "Super farm",
    
    BUILDING_ENEMY_SPAWN = "Enemy lair",
    ENEMY_SMALL = "Minor monster",
    ENEMY_LARGE = "Big bad monster",
}

const ENTITY_DESCRIPTIONS := {
    HERO = [
        "Commands workers.",
        "Can attack enemies.",
        "Can collect money.",
    ],
    
    SMALL_WORKER = [
        "Minor productivity and strength.",
        "Can build and upgrade structures.",
        "Can occupy towers and farms.",
        "Can attack enemies.",
        "Can collect money.",
    ],
    MEDIUM_WORKER = [
        "Moderate productivity and strength.",
        "Can build and upgrade structures.",
        "Can occupy towers and farms.",
        "Can attack enemies.",
        "Can collect money.",
    ],
    LARGE_WORKER = [
        "Major productivity and strength.",
        "Can build and upgrade structures.",
        "Can occupy towers and farms.",
        "Can attack enemies.",
        "Can collect money.",
    ],
    
    BUILDING_EMPTY = [
        "Empty plot of land.",
        "You should probably build something here.",
    ],
    
    SMALL_BASE = [
        "Minorly fortified.",
        "New workers spawn here (up to a limit).",
        "Workers can be upgraded here.",
    ],
    MEDIUM_BASE = [
        "Moderately fortified.",
        "New workers spawn here (up to a limit).",
        "Workers can be upgraded here.",
    ],
    LARGE_BASE = [
        "Majorly fortified.",
        "New workers spawn here (up to a limit).",
        "Workers can be upgraded here.",
    ],
    
    SMALL_TOWER = [
        "Minor fortification and range.",
        "A worker can occupy this tower to defend from monsters.",
    ],
    MEDIUM_TOWER = [
        "Moderate fortification and range.",
        "A worker can occupy this tower to defend from monsters.",
    ],
    LARGE_TOWER = [
        "Major fortification and range.",
        "A worker can occupy this tower to defend from monsters.",
    ],
    
    SMALL_FARM = [
        "Meager production.",
        "A worker can occupy this farm to grow cash crops.",
    ],
    MEDIUM_FARM = [
        "Moderate production.",
        "A worker can occupy this farm to grow cash crops.",
    ],
    LARGE_FARM = [
        "Bountiful production.",
        "A worker can occupy this farm to grow cash crops.",
    ],
    
    BUILDING_ENEMY_SPAWN = [
        "Very dark in here.",
        "Seems pretty scary--I wouldn't go in.",
        "Probably best to just attack this until it collapses.",
    ],
    ENEMY_SMALL = [
        "Peevish.",
        "Minor strength.",
        "Can attack structures.",
    ],
    ENEMY_LARGE = [
        "Quite grumpy.",
        "Major strength.",
        "Can attack structures.",
    ],
}

const COMMAND_LABELS := {
    FRIENDLY_SMALL_UPGRADE = "Upgrade",
    FRIENDLY_MEDIUM_UPGRADE = "Upgrade",
    FRIENDLY_RALLY = "Rally all workers",
    FRIENDLY_MOVE = "Move",
    FRIENDLY_STOP = "Stop",
    FRIENDLY_INFO = "Info",
    
    BUILDING_EMPTY = "??????",
    BUILDING_BASE = "??????",
    BUILDING_TOWER = "Build guard tower",
    BUILDING_FARM = "Build farm",
    
    BUILDING_BASE_UPGRADE = "Upgrade",
    BUILDING_TOWER_UPGRADE = "Upgrade",
    BUILDING_FARM_UPGRADE = "Upgrade",
    
    BUILDING_OCCUPY = "Occupy",
    BUILDING_VACATE = "Vacate",
    BUILDING_RECYCLE = "Destroy",
    BUILDING_STOP = "Stop",
    BUILDING_INFO = "Info",
    
    SMALL_BASE = "Upgrade base",
    MEDIUM_BASE = "Upgrade base",
    LARGE_BASE = "Upgrade base",
    
    SMALL_TOWER = "Upgrade guard tower",
    MEDIUM_TOWER = "Upgrade guard tower",
    LARGE_TOWER = "Build large guard tower",
    
    SMALL_FARM = "Upgrade farm",
    MEDIUM_FARM = "Upgrade farm",
    LARGE_FARM = "Upgrade farm",
    
    BUILDING_ENEMY_SPAWN = "???",
    ENEMY_SMALL = "???",
    ENEMY_LARGE = "???",
}

const COMMAND_DESCRIPTIONS := {
    FRIENDLY_SMALL_UPGRADE = [
        "Commands this worker to return the base and upgrade themselves. This requires a second worker of matching strength to be upgraded as well.",
    ],
    FRIENDLY_MEDIUM_UPGRADE = [
        "Commands this worker to return the base and upgrade themselves. This requires a second worker of matching strength to be upgraded as well.",
    ],
    FRIENDLY_RALLY = [
        "Commands all workers to abandon their current task and come to the hero's aid.",
    ],
    FRIENDLY_MOVE = [
        "Moves this worker.",
    ],
    FRIENDLY_STOP = [
        "Stops this worker.",
    ],
    FRIENDLY_INFO = [
        "Shows more information about this unit.",
    ],
    
    BUILDING_EMPTY = [
        "??????.",
    ],
    BUILDING_BASE = [
        "??????.",
    ],
    BUILDING_TOWER = [
        "Builds a guard tower, which defends against monsters.",
    ],
    BUILDING_FARM = [
        "Builds a farm, which grows cash crops.",
    ],
    BUILDING_BASE_UPGRADE = [
        "Upgrades your base. A better base allows better worker and structure upgrades.",
    ],
    BUILDING_TOWER_UPGRADE = [
        "Upgrades this guard tower. A better tower has more health and can shoot further.",
    ],
    BUILDING_FARM_UPGRADE = [
        "Upgrades this farm. A better farm yields more money from each harvest.",
    ],
    
    BUILDING_OCCUPY = [
        "Commands an idle worker to occupy this structure.",
    ],
    BUILDING_VACATE = [
        "Commands workers to leave this structure empty",
    ],
    BUILDING_RECYCLE = [
        "Commands a worker to destroy this building.",
    ],
    BUILDING_STOP = [
        "Stops this building",
    ],
    BUILDING_INFO = [
        "Shows more information about this structure.",
    ],
    
    SMALL_BASE = [
        "Builds a small base.",
    ],
    MEDIUM_BASE = [
        "Upgrades your base. A better base provides more health and attack.",
    ],
    LARGE_BASE = [
        "Upgrades your base. A better base provides more health and attack.",
    ],
    SMALL_TOWER = [
        "Builds a guard tower, which defends against monsters.",
    ],
    MEDIUM_TOWER = [
        "Upgrades this guard tower. A better tower has more health and can shoot further.",
    ],
    LARGE_TOWER = [
        "Upgrades this guard tower. A better tower has more health and can shoot further.",
    ],
    SMALL_FARM = [
        "Builds a farm, which grows cash crops.",
    ],
    MEDIUM_FARM = [
        "Upgrades this farm. A better farm yields more money from each harvest.",
    ],
    LARGE_FARM = [
        "Upgrades this farm. A better farm yields more money from each harvest.",
    ],
    
    BUILDING_ENEMY_SPAWN = [
        "???.",
    ],
    ENEMY_SMALL = [
        "???.",
    ],
    ENEMY_LARGE = [
        "???.",
    ],
}
