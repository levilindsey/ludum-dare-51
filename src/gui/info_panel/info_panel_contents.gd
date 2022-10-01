tool
class_name InfoPanelContents
extends VBoxContainer


const _INFO_PANEL_COMMAND_ROW_SCENE := preload(
    "res://src/gui/info_panel/info_panel_command_row.tscn")

var CONNECTION_STATUS_CONNECTED_COLOR := \
    ColorFactory.opacify("connected_background", 0.3)
var CONNECTION_STATUS_DISCONNECTED_COLOR := \
    ColorFactory.opacify("disconnected_background", 0.3)

var entity
var entity_command_type := CommandType.UNKNOWN
# Array<InfoPanelCommandRow>
var command_rows := []


func set_up(entity) -> void:
    self.entity = entity
    self.entity_command_type = entity.entity_command_type
    
    $CommandsLabel \
        .add_color_override("font_color", Sc.palette.get_color("info_panel_header"))
    $UpgradesLabel \
        .add_color_override("font_color", Sc.palette.get_color("info_panel_header"))
    
    $CommandsSeparator.modulate = Sc.palette.get_color("separator")
    $UpgradesSeparator.modulate = Sc.palette.get_color("separator")
    
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
    for command in commands:
        if command == CommandType.STATION_INFO or \
                command == CommandType.BOT_INFO or \
                command == CommandType.BARRIER_INFO:
            continue
        var row: InfoPanelCommandRow = \
            Sc.utils.add_scene($Commands, _INFO_PANEL_COMMAND_ROW_SCENE)
        row.set_up(command)
        command_rows.push_back(row)
    
    $Status/HealthLabel.entity = entity
    $Status/HealthLabel.set_up()
    
    var is_empty_station := entity_command_type == CommandType.STATION_EMPTY
    $Status.visible = !is_empty_station
    $UpgradesSeparator.visible = !is_empty_station
    $UpgradesLabel.visible = !is_empty_station
    $Upgrades.visible = !is_empty_station
    
    update()


func update() -> void:
    if entity is CommandCenter or \
            entity is EmptyStation or \
            entity is Bot or \
            entity is BarrierPylon:
        $ConnectionStatus.visible = false
    elif entity is Station:
        $ConnectionStatus.visible = true
        $ConnectionStatus/ScaffolderPanelContainer.color_override = \
            CONNECTION_STATUS_CONNECTED_COLOR if \
            entity.is_connected_to_command_center else \
            CONNECTION_STATUS_DISCONNECTED_COLOR
        $ConnectionStatus/ScaffolderPanelContainer/HBoxContainer/ScaffolderLabel.text = \
            Description.IS_CONNECTED if \
            entity.is_connected_to_command_center else \
            Description.IS_DISCONNECTED
    else:
        Sc.logger.error("InfoPanelContents.update")
    
    if entity is BarrierPylon:
        $BarrierActiveStatus.visible = true
        $BarrierActiveStatus/ScaffolderPanelContainer.color_override = \
            CONNECTION_STATUS_CONNECTED_COLOR if \
            entity.get_is_active() else \
            CONNECTION_STATUS_DISCONNECTED_COLOR
        $BarrierActiveStatus/ScaffolderPanelContainer/HBoxContainer/ScaffolderLabel.text = \
            Description.BARRIER_IS_ACTIVE if \
            entity.get_is_active() else \
            Description.BARRIER_IS_INACTIVE
    else:
        $BarrierActiveStatus.visible = false
    
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
