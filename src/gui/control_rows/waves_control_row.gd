class_name WavesControlRow
extends TextControlRow


const LABEL := "Waves:"
const DESCRIPTION := ""

var level_id: String


func _init(level_session_or_id).(
        LABEL,
        DESCRIPTION \
        ) -> void:
    pass


func get_text() -> String:
    var count: int = \
        Sc.levels.session.wave_count if \
        Sc.levels.session.has_started else \
        0
    return str(count)
