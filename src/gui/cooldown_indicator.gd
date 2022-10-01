tool
class_name CooldownIndicator
extends ScaffolderPanelContainer


const _SIZE := Vector2(64.0, 64.0)
const _FRAME_COUNT := 80

var current_frame := 0


func _ready() -> void:
    Sc.gui.add_gui_to_scale(self)
    _on_gui_scale_changed()


func _destroy() -> void:
    Sc.gui.remove_gui_to_scale(self)
    queue_free()


func _on_gui_scale_changed() -> bool:
    for child in Sc.utils.get_children_by_type(self, Control):
        Sc.gui.scale_gui_recursively(child)
    
    var size: Vector2 = _SIZE * Sc.gui.scale
    rect_min_size = size
    rect_size = size
    
    rect_position.x = (Sc.device.get_viewport_size().x - size.x) / 2.0
    rect_position.y = InspectorPanel.FOOTER_MARGIN_TOP * Sc.gui.scale
    
    return true


func _physics_process(_delta: float) -> void:
    var next_frame := int(Game.cooldown_ratio * _FRAME_COUNT)
    if next_frame != current_frame:
        current_frame = next_frame
        $Progress.frame = current_frame
