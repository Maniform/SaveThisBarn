class_name PlayerController extends Node

enum INPUT_GAME_MODE {NONE, UI, GAME}

var input_game_mode:= INPUT_GAME_MODE.UI as INPUT_GAME_MODE
var fullscreen: bool
var window_modes = [
	DisplayServer.WINDOW_MODE_WINDOWED,
	DisplayServer.WINDOW_MODE_FULLSCREEN
]

signal fullscreen_state_changed(enabled: bool)

# Called when the node enters the scene tree for the first time.
func _ready():
	fullscreen = (DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN || DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_toggle_fullscreen"):
		set_fullscreen(!fullscreen)

func set_fullscreen(enabled: bool):
	fullscreen = enabled
	DisplayServer.window_set_mode(window_modes[int(fullscreen)])
	fullscreen_state_changed.emit(fullscreen)
