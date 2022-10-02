tool
class_name InfoPanelContents
extends VBoxContainer


const _INFO_PANEL_COMMAND_ROW_SCENE := preload(
    "res://src/gui/info_panel/info_panel_command_row.tscn")

var entity
var entity_command_type := CommandType.UNKNOWN
# Array<InfoPanelCommandRow>
var command_rows := []


func set_up(entity) -> void:
    self.entity = entity
    self.entity_command_type = entity.entity_command_type
    
    $CommandsLabel \
        .add_color_override("font_color", Sc.palette.get_color("info_panel_header"))
    
    # Render bulleted description rows.
    var description_lines: Array = \
        CommandType.ENTITY_DESCRIPTIONS[entity_command_type]
    for line in description_lines:
        var row := HBoxContainer.new()
        $Description.add_child(row)
        
        var row_bullet: ScaffolderLabel = Sc.utils.add_scene(
            row, Sc.gui.SCAFFOLDER_LABEL_SCENE)
        row_bullet.text = "-  "
        row_bullet.font_size = "Xs"
        row_bullet.align = Label.ALIGN_RIGHT
        row_bullet.valign = Label.VALIGN_TOP
        row_bullet.size_flags_vertical = SIZE_FILL
        row_bullet.size_override = Vector2(61.0, 0.0)
        
        var row_label: ScaffolderLabel = Sc.utils.add_scene(
            row, Sc.gui.SCAFFOLDER_LABEL_SCENE)
        row_label.text = line
        row_label.font_size = "Xs"
        row_label.align = Label.ALIGN_LEFT
        row_label.valign = Label.VALIGN_TOP
        row_label.size_flags_horizontal = SIZE_EXPAND_FILL
        row_bullet.size_flags_vertical = SIZE_FILL
        row_label.autowrap = true
    
    # Render command rows.
    var commands: Array = entity._get_radial_menu_item_types()
    var is_a_command_rendered := false
    for command in commands:
        if command == CommandType.BUILDING_INFO or \
                command == CommandType.FRIENDLY_INFO:
            continue
        is_a_command_rendered = true
        var row: InfoPanelCommandRow = \
            Sc.utils.add_scene($Commands, _INFO_PANEL_COMMAND_ROW_SCENE)
        row.set_up(command)
        command_rows.push_back(row)
    if !is_a_command_rendered:
        $Commands.visible = false
        $CommandsLabel.visible = false
        $CommandsSeparator.visible = false
    
    $Status/HealthLabel.entity = entity
    $Status/HealthLabel.set_up()
    
    var is_empty_building := entity_command_type == CommandType.BUILDING_EMPTY
    $Status.visible = !is_empty_building
    
    update()


func update() -> void:
    if entity.get_health_capacity() < 0:
        $Status.visible = false
    
    $Status/HealthLabel.update()
    
    for row in command_rows:
        row.update()


func get_data() -> InfoPanelData:
    var name: String = CommandType.ENTITY_NAMES[entity_command_type]
    var data := InfoPanelData.new(name, self)
    data.meta = entity
    return data
