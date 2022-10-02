class_name MoneyControlRow
extends CustomControlRow


const LABEL := "Money:"
const DESCRIPTION := ""

const _COST_LABEL_SCENE := preload("res://src/gui/cost_label.tscn")

var header: ScaffolderLabel
var cost_label: CostLabel

var text: String


func _init(__ = null).(
        LABEL,
        DESCRIPTION \
        ) -> void:
    pass


func _update_control() -> void:
    var current_money: int = \
        Sc.levels.session.current_money if \
        Sc.levels.session.has_started else \
        0
    text = str(current_money)
    if is_instance_valid(cost_label):
        cost_label.text = text


func create_control() -> Control:
    var container: Control
    
    header = Sc.gui.SCAFFOLDER_LABEL_SCENE.instance()
    header.text = "Money:"
    
    cost_label = _COST_LABEL_SCENE.instance()
    cost_label.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
    
    # Display in one justified row.
    container = HBoxContainer.new()
    container.add_child(header)
    container.add_child(cost_label)
    
    header.size_flags_horizontal = Control.SIZE_EXPAND_FILL
    header.align = Label.ALIGN_LEFT
    cost_label.size_flags_horizontal = Control.SIZE_SHRINK_END
    
    container.size_flags_horizontal = Control.SIZE_EXPAND_FILL
    
    _set_font_size(font_size)
    _update_control()
    
    return container


func _set_font_size(value: String) -> void:
    ._set_font_size(value)
    
    if !is_instance_valid(cost_label):
        return
    
    header.font_size = value
    cost_label.font_size = value
