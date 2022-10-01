class_name FriendlyStatus
extends Reference


enum {
    UNKNOWN,
    NEW,
    ACTIVE,
    IDLE,
    SELECTED,
    HOVERED,
    STOPPING,
}

const HIGHLIGHT_CONFIGS := {
    NEW: {
        color = "friendly_new",
        scale = 0.1,
        energy = 1.0,
        outline_alpha_multiplier = 0.99,
    },
    ACTIVE: {
        color = "friendly_active",
        scale = 0.1,
        energy = 0.3,
        outline_alpha_multiplier = 0.99,
    },
    IDLE: {
        color = "friendly_idle",
        scale = 0.1,
        energy = 0.8,
        outline_alpha_multiplier = 0.99,
    },
    SELECTED: {
        color = "friendly_selected",
        scale = 0.1,
        energy = 1.1,
        outline_alpha_multiplier = 0.99,
    },
    HOVERED: {
        color = "friendly_hovered",
        scale = 0.1,
        energy = 1.1,
        outline_alpha_multiplier = 0.99,
    },
}


static func get_string(type: int) -> String:
    match type:
        UNKNOWN:
            return "UNKNOWN"
        NEW:
            return "NEW"
        ACTIVE:
            return "ACTIVE"
        IDLE:
            return "IDLE"
        SELECTED:
            return "SELECTED"
        HOVERED:
            return "HOVERED"
        STOPPING:
            return "STOPPING"
        _:
            Sc.logger.error("BotStatus.get_string")
            return ""
