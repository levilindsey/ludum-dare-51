tool
class_name GameSchema
extends FrameworkSchema


const _METADATA_SCRIPT := GameMetadata

var _metadata := {
    pauses_on_focus_out = false, # FIXME: ----------
    also_prints_to_stdout = true,
    logs_character_events = true,
    logs_analytics_events = true,
    logs_bootstrap_events = true,
    logs_device_settings = true,
    logs_in_editor_events = true,
    is_profiler_enabled = true,
    are_all_levels_unlocked = true, # FIXME: ----------
    are_test_levels_included = true, # FIXME: ----------
    is_save_state_cleared_for_debugging = false, # FIXME: ----------
    opens_directly_to_level_id = "", # FIXME: ----------
    is_splash_skipped = false, # FIXME: ----------
    uses_threads = false,
    thread_count = 1,
    rng_seed = 176,
    is_mobile_supported = true,
    uses_level_scores = true,
    must_restart_level_to_change_settings = true,
    overrides_project_settings = true,
    overrides_input_map = true,
    are_button_controls_enabled_by_default = false,
    base_path = "",
    
    app_name = "Village Defender",
    app_id = "dev.levi.ludum_dare_51",
    app_version = "0.0.1",
    score_version = "0.0.1",
    data_agreement_version = "0.0.1",
    
    # Must start with "UA-".
    google_analytics_id = "",
    privacy_policy_url = "",
    terms_and_conditions_url = "",
    android_app_store_url = "",
    ios_app_store_url = "",
    support_url = "",
    log_gestures_url = "",
    error_logs_url = "",
    app_id_query_param = "",
    
    developer_name = "Levi Lindsey",
    developer_url = "https://levi.dev",
    github_url = "https://github.com/levilindsey/ludum-dare-51",
    
    godot_splash_screen_duration = 0.8,
    developer_splash_screen_duration = 1.0,
}

# FIXME: ----------
var _music_manifest := [
    # NOTE:
    # -   I'm hacking this a bit.
    # -   BPMs are used as a seconds tracker, and aren't actually accurate.
    {
        name = "await-judgement",
        path_prefix = "res://assets/music/",
        volume_db = 0.0,
        bpm = 240.0,
        meter = 4,
    },
    {
        name = "fight-the-beat",
        path_prefix = "res://assets/music/",
        volume_db = 0.0,
        bpm = 240.0,
        meter = 10,
    },
]

var _sounds_manifest := [
    {
        name = "jump",
        volume_db = 0.0,
        path_prefix = "",
    },
    {
        name = "land",
        volume_db = 0.0,
        path_prefix = "",
    },
    {
        name = "land",
        volume_db = 0.0,
        path_prefix = "",
    },
    {
        name = "cadence",
        volume_db = 0.0,
        path_prefix = "",
    },
]

var _audio_manifest := {
    sounds_manifest = _sounds_manifest,
    default_sounds_path_prefix = "res://assets/sounds/",
    default_sounds_file_suffix = ".wav",
    default_sounds_bus_index = 1,
    
    music_manifest = _music_manifest,
    default_music_path_prefix = "res://assets/music/",
    default_music_file_suffix = ".ogg",
    default_music_bus_index = 2,
    
    godot_splash_sound = "achievement",
    developer_splash_sound = "cadence",
    level_end_sound_win = "cadence",
    level_end_sound_lose = "cadence",
    
    main_menu_music = "await-judgement",
    game_over_music = "await-judgement",
    pause_menu_music = "await-judgement",
    default_level_music = "fight-the-beat",
    
    pauses_level_music_on_pause = true,
    
    are_beats_tracked_by_default = false,
    
    is_arbitrary_music_speed_change_supported = false,
    is_music_speed_scaled_with_time_scale = false,
    is_music_speed_scaled_with_additional_debug_time_scale = false,
    
    is_music_paused_in_slow_motion = false,
    is_tick_tock_played_in_slow_motion = false,
    is_slow_motion_start_stop_sound_effect_played = true,
}

var _images_manifest_pixelated := {
    checkbox_path_prefix = \
            ScaffolderImages.DEFAULT_CHECKBOX_PIXEL_PATH_PREFIX,
    default_checkbox_size = \
            ScaffolderImages.DEFAULT_CHECKBOX_PIXEL_SIZE,
    checkbox_sizes = \
            ScaffolderImages.DEFAULT_CHECKBOX_PIXEL_SIZES,
    
    radio_button_path_prefix = \
            ScaffolderImages.DEFAULT_RADIO_BUTTON_PIXEL_PATH_PREFIX,
    default_radio_button_size = \
            ScaffolderImages.DEFAULT_RADIO_BUTTON_PIXEL_SIZE,
    radio_button_sizes = \
            ScaffolderImages.DEFAULT_RADIO_BUTTON_PIXEL_SIZES,
    
    tree_arrow_path_prefix = \
            ScaffolderImages.DEFAULT_TREE_ARROW_PIXEL_PATH_PREFIX,
    default_tree_arrow_size = \
            ScaffolderImages.DEFAULT_TREE_ARROW_PIXEL_SIZE,
    tree_arrow_sizes = \
            ScaffolderImages.DEFAULT_TREE_ARROW_PIXEL_SIZES,
    
    dropdown_arrow_path_prefix = \
            ScaffolderImages.DEFAULT_DROPDOWN_ARROW_PIXEL_PATH_PREFIX,
    default_dropdown_arrow_size = \
            ScaffolderImages.DEFAULT_DROPDOWN_ARROW_PIXEL_SIZE,
    dropdown_arrow_sizes = \
            ScaffolderImages.DEFAULT_DROPDOWN_ARROW_PIXEL_SIZES,
    
    slider_grabber_path_prefix = \
            ScaffolderImages.DEFAULT_SLIDER_GRABBER_PIXEL_PATH_PREFIX,
    default_slider_grabber_size = \
            ScaffolderImages.DEFAULT_SLIDER_GRABBER_PIXEL_SIZE,
    slider_grabber_sizes = \
            ScaffolderImages.DEFAULT_SLIDER_GRABBER_PIXEL_SIZES,
    
    slider_tick_path_prefix = \
            ScaffolderImages.DEFAULT_SLIDER_TICK_PIXEL_PATH_PREFIX,
    default_slider_tick_size = \
            ScaffolderImages.DEFAULT_SLIDER_TICK_PIXEL_SIZE,
    slider_tick_sizes = \
            ScaffolderImages.DEFAULT_SLIDER_TICK_PIXEL_SIZES,
    
    app_logo = preload("res://assets/images/logos/logo.png"),
    app_logo_scale = 1.0,
    
    developer_logo = preload("res://assets/images/logos/levi_logo_about.png"),
    developer_splash = preload("res://assets/images/logos/levi_logo_splash.png"),
    
    go_normal = preload("res://assets/images/logos/go_icon.png"),
    go_scale = 4.0,
    
    about_circle_pressed = preload(
            "res://addons/scaffolder/assets/images/gui/icons/about_circle_pressed.png"),
    about_circle_hover = preload(
            "res://addons/scaffolder/assets/images/gui/icons/about_circle_hover.png"),
    about_circle_normal = preload(
            "res://addons/scaffolder/assets/images/gui/icons/about_circle_normal.png"),
    
    alert_normal = \
            preload("res://addons/scaffolder/assets/images/gui/icons/alert_normal.png"),
    
    close_pressed = \
            preload("res://addons/scaffolder/assets/images/gui/icons/close_pressed.png"),
    close_hover = \
            preload("res://addons/scaffolder/assets/images/gui/icons/close_hover.png"),
    close_normal = \
            preload("res://addons/scaffolder/assets/images/gui/icons/close_normal.png"),
    
    gear_circle_pressed = \
            preload("res://addons/scaffolder/assets/images/gui/icons/gear_circle_pressed.png"),
    gear_circle_hover = \
            preload("res://addons/scaffolder/assets/images/gui/icons/gear_circle_hover.png"),
    gear_circle_normal = \
            preload("res://addons/scaffolder/assets/images/gui/icons/gear_circle_normal.png"),
    
    home_normal = \
            preload("res://addons/scaffolder/assets/images/gui/icons/home_normal.png"),
    
    left_caret_pressed = \
            preload("res://addons/scaffolder/assets/images/gui/icons/left_caret_pressed.png"),
    left_caret_hover = \
            preload("res://addons/scaffolder/assets/images/gui/icons/left_caret_hover.png"),
    left_caret_normal = \
            preload("res://addons/scaffolder/assets/images/gui/icons/left_caret_normal.png"),
    
    pause_circle_pressed = \
            preload("res://addons/scaffolder/assets/images/gui/icons/pause_circle_pressed.png"),
    pause_circle_hover = \
            preload("res://addons/scaffolder/assets/images/gui/icons/pause_circle_hover.png"),
    pause_circle_normal = \
            preload("res://addons/scaffolder/assets/images/gui/icons/pause_circle_normal.png"),
    
    pause_normal = \
            preload("res://addons/scaffolder/assets/images/gui/icons/pause_normal.png"),
    play_normal = \
            preload("res://addons/scaffolder/assets/images/gui/icons/play_normal.png"),
    retry_normal = \
            preload("res://addons/scaffolder/assets/images/gui/icons/retry_normal.png"),
    stop_normal = \
            preload("res://addons/scaffolder/assets/images/gui/icons/stop_normal.png"),
}

var _styles_manifest_pixelated := {
    focus_border_nine_patch = \
            preload("res://assets/images/gui/nine_patch/focus_border.png"),
    button_pressed_nine_patch = \
            preload("res://assets/images/gui/nine_patch/button_pressed.png"),
    button_disabled_nine_patch = \
            preload("res://assets/images/gui/nine_patch/button_hover.png"),
    button_hover_nine_patch = \
            preload("res://assets/images/gui/nine_patch/button_hover.png"),
    button_normal_nine_patch = \
            preload("res://assets/images/gui/nine_patch/button_normal.png"),
    dropdown_pressed_nine_patch = \
            preload("res://assets/images/gui/nine_patch/dropdown_pressed.png"),
    dropdown_disabled_nine_patch = \
            preload("res://assets/images/gui/nine_patch/dropdown_hover.png"),
    dropdown_hover_nine_patch = \
            preload("res://assets/images/gui/nine_patch/dropdown_hover.png"),
    dropdown_normal_nine_patch = \
            preload("res://assets/images/gui/nine_patch/dropdown_normal.png"),
    scroll_track_nine_patch = \
            preload("res://assets/images/gui/nine_patch/scroll_track.png"),
    scroll_grabber_pressed_nine_patch = \
            preload("res://assets/images/gui/nine_patch/scroll_grabber_pressed.png"),
    scroll_grabber_hover_nine_patch = \
            preload("res://assets/images/gui/nine_patch/scroll_grabber_hover.png"),
    scroll_grabber_normal_nine_patch = \
            preload("res://assets/images/gui/nine_patch/scroll_grabber_normal.png"),
    slider_track_nine_patch = \
            preload("res://assets/images/gui/nine_patch/slider_track.png"),
    overlay_panel_nine_patch = \
            preload("res://assets/images/gui/nine_patch/overlay_panel.png"),
#    notification_panel_nine_patch = \
#            preload("res://assets/images/gui/nine_patch/notification_panel.png"),
    hud_panel_nine_patch = \
            preload("res://assets/images/gui/nine_patch/hud_panel.png"),
}

var _gui_manifest := {
    third_party_license_text = \
            ThirdPartyLicenses.TEXT + \
            SurfaceTilerThirdPartyLicenses.TEXT + \
            ScaffolderThirdPartyLicenses.TEXT + \
            SurfacerThirdPartyLicenses.TEXT,
    
    main_menu_image_scale = 1.0,
    game_over_image_scale = 0.5,
    loading_image_scale = 0.5,
    
    display_time_type = TimeType.PLAY_PHYSICS_SCALED,
    
    welcome_panel_scene = preload(
        "res://addons/scaffolder/src/gui/welcome_panel.tscn"),
    main_menu_image_scene = preload("res://src/gui/loading_image.tscn"),
    game_over_image_scene = preload("res://src/gui/loading_image.tscn"),
    loading_image_scene = preload("res://src/gui/loading_image.tscn"),
    
    settings_item_manifest = {
        groups = {
            annotations = {
                item_classes = [
                ],
            },
            hud = {
                item_classes = [
                ],
            },
            miscellaneous = {
                item_classes = [
                ],
            },
        },
    },
    # FIXME: ----------
    pause_item_manifest = [
        TimeControlRow,
        LevelControlRow,
#        FastestTimeControlRow,
#        LongestTimeControlRow,
#        ScoreControlRow,
#        HighScoreControlRow,
        WavesControlRow,
        WorkersControlRow,
        EnemiesControlRow,
        MoneyControlRow,
    ],
    game_over_item_manifest = [
#        FastestTimeControlRow,
#        LongestTimeControlRow,
        TimeControlRow,
        LevelControlRow,
        WavesControlRow,
    ],
    level_select_item_manifest = [
        TotalPlaysControlRow,
#        FastestTimeControlRow,
#        LongestTimeControlRow,
    ],
    hud_manifest = {
        hud_class = Hud,
        hud_key_value_box_size = Vector2(200.0, 64.0),
        hud_key_value_list_item_manifest = [
            {
                item_class = TimeControlRow,
                settings_enablement_label = "Time",
                enabled_by_default = false,
                settings_group_key = "hud",
            },
            {
                item_class = WavesControlRow,
                settings_enablement_label = "Waves survived",
                enabled_by_default = true,
                settings_group_key = "hud",
            },
            {
                item_class = WorkersControlRow,
                settings_enablement_label = "Workers",
                enabled_by_default = true,
                settings_group_key = "hud",
            },
            {
                item_class = EnemiesControlRow,
                settings_enablement_label = "Enemies",
                enabled_by_default = true,
                settings_group_key = "hud",
            },
            {
                item_class = MoneyControlRow,
                settings_enablement_label = "Money",
                enabled_by_default = true,
                settings_group_key = "hud",
            },
        ],
        is_hud_visible_by_default = true,
        is_inspector_enabled_default = false,
        inspector_panel_starts_open = false,
        is_key_value_list_consolidated = true,
        
        radial_menu_class = GameRadialMenu,
        radial_menu_label_scene = preload(
            "res://src/gui/radial_menu/game_radial_menu_label.tscn"),
        radial_menu_item_hovered_scale = 2.0,
        radial_menu_radius = 96.0,
        radial_menu_item_radius = 30.0,
        radial_menu_open_duration = 0.25,
        radial_menu_close_duration = 0.25,
        radial_menu_item_hover_duration = 0.2,
        radial_menu_closed_item_angular_offset = -PI / 3,
        radial_menu_item_normal_color_modulate = \
            ColorFactory.palette("modulation_button_normal"),
        radial_menu_item_hover_color_modulate = \
            ColorFactory.palette("modulation_button_hover"),
        radial_menu_item_disabled_color_modulate = \
            ColorFactory.palette("modulation_button_disabled"),
    },
    welcome_panel_manifest = {
#        is_header_shown = true,
        items = [
            ["Move", "AWSD / Arrows"],
            ["Jump", "Space"],
            ["Select/Command unit", "L-click"],
            ["Zoom in/out", "Scroll-wheel"],
        ],
    },
    screen_manifest = {
        screens = [
            preload("res://src/gui/ld_loading_screen.tscn"),
        ],
    },
}

var _character_scenes := [
    preload("res://src/characters/hero/hero.tscn"),
    preload("res://src/characters/large_enemy/large_enemy.tscn"),
    preload("res://src/characters/small_enemy/small_enemy.tscn"),
    preload("res://src/characters/worker/worker.tscn"),
]

func _get_worker_collider_shape() -> Shape2D:
    var shape := CapsuleShape2D.new()
    shape.radius = 17.0
    shape.height = 9.0
    return shape

func _get_hero_collider_shape() -> Shape2D:
    var shape := CapsuleShape2D.new()
    shape.radius = 17.0
    shape.height = 9.0
    return shape

func _get_large_enemy_collider_shape() -> Shape2D:
    var shape := CapsuleShape2D.new()
    shape.radius = 17.0
    shape.height = 9.0
    return shape

var _character_categories := [
]

var _character_manifest := {
    default_player_character_name = "hero",
    character_scenes = _character_scenes,
    character_categories = _character_categories,
    omits_npcs = false,
    can_include_player_characters = true,
}

var _level_manifest := {
    level_config_class = LevelConfig,
    level_session_class = LevelSession,
    default_camera_bounds_level_margin = \
        ScaffolderLevelConfig.DEFAULT_CAMERA_BOUNDS_LEVEL_MARGIN,
    default_character_bounds_level_margin = \
        ScaffolderLevelConfig.DEFAULT_CHARACTER_BOUNDS_LEVEL_MARGIN,
}

var _properties := {
}

var _additive_overrides := {
    ScaffolderSchema: {
        metadata = _metadata,
        audio_manifest = _audio_manifest,
        images_manifest_pixelated = _images_manifest_pixelated,
        styles_manifest_pixelated = _styles_manifest_pixelated,
        character_manifest = _character_manifest,
        level_manifest = _level_manifest,
        gui_manifest = _gui_manifest,
        colors_manifest = \
            Utils.get_direct_color_properties(GameDefaultColors.new()),
        annotation_parameters_manifest = Sc.utils.merge(
            Utils.get_direct_non_color_properties(
                GameDefaultAnnotationParameters.new()),
            Utils.get_direct_non_color_properties(
                GameDefaultColors.new())),
        camera_manifest = {
            default_camera_class = SwipeCamera,
#            default_camera_class = NavigationPreselectionCamera,
            snaps_camera_back_to_character = true,
#            default_camera_class = SwipeCamera,
#            snaps_camera_back_to_character = false,
        },
        slow_motion_manifest = {
            default_time_scale = 0.5,
            gui_mode_time_scale = 0.07,
            tick_tock_tempo_multiplier = 1,
            saturation = 0.3,
        },
        annotators_class = GameAnnotators,
    },
    SurfacerSchema: {
        movement_manifest = {
            uses_point_and_click_navigation = false,
            do_player_actions_interrupt_navigation = true,
        },
        cancel_active_player_control_on_invalid_nav_selection = true,
    },
    SurfaceTilerSchema: {
        includes_intra_subtile_45_concave_cusps = true,
        tilesets = [
            {
                recalculate_tileset = [TYPE_CUSTOM, RecalculateTilesetCustomProperty],
                tile_set = preload("res://src/tiles/collidable_tileset.tres"),
                quadrant_size = 16,
                corner_match_tiles = [
                    {
                        outer_autotile_name = "autotile",
                        inner_autotile_name = "__inner_autotile__",
                        tileset_quadrants_path = \
                            "res://assets/images/tiles/tileset_quadrants.png",
                        tile_corner_type_annotations_path = \
                            "res://assets/images/tiles/tileset_corner_type_annotations.png",
                        subtile_collision_margin = 3.0,
                        are_45_degree_subtiles_used = true,
                        are_27_degree_subtiles_used = false,
                        properties = "default",
                        is_collidable = true,
                    },
                ],
                non_corner_match_tiles = [
                    {
                        name = "decorations",
                        properties = "",
                        is_collidable = false,
                    },
                ],
            },
        ],
    },
}

var _subtractive_overrides := {
    ScaffolderSchema: {
        character_manifest = {
            character_scenes = [
                preload("res://addons/squirrel_away/src/characters/squirrel/squirrel.tscn"),
            ],
            character_categories = [
                # ScaffolderSchema._SQUIRREL_CATEGORY,
            ],
        },
        gui_manifest = {
            welcome_panel_manifest = {
                items = [
                    SurfacerSchema.WELCOME_PANEL_ITEM_AUTO_NAV,
                    ScaffolderSchema.WELCOME_PANEL_ITEM_MOVE,
                    ScaffolderSchema.WELCOME_PANEL_ITEM_JUMP,
                ],
            },
            settings_item_manifest = {
                groups = {
                    main = {
                        item_classes = [
#                            MusicControlRow,
#                            SoundEffectsControlRow,
#                            HapticFeedbackControlRow,
                        ],
                    },
                    annotations = {
                        item_classes = [
#                            RulerAnnotatorControlRow,
#                            RecentMovementAnnotatorControlRow,
#                            CharacterAnnotatorControlRow,
#                            LevelAnnotatorControlRow,
                        ],
                    },
                    hud = {
                        item_classes = [
#                            DebugPanelControlRow,
                        ],
                    },
                    miscellaneous = {
                        item_classes = [
#                            ButtonControlsControlRow,
                            WelcomePanelControlRow,
#                            CameraZoomControlRow,
#                            TimeScaleControlRow,
#                            MetronomeControlRow,
                        ],
                    },
                },
            }
        },
    },
    SurfaceTilerSchema: {
        tilesets = [
            SurfacerSchema.DEFAULT_TILESET_CONFIG,
        ],
    },
}


func _init().(
        _METADATA_SCRIPT,
        _properties,
        _additive_overrides,
        _subtractive_overrides) -> void:
    pass
