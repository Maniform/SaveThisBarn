extends Node

var current_window_mode = 0
var window_modes = [
	DisplayServer.WINDOW_MODE_WINDOWED,
	DisplayServer.WINDOW_MODE_FULLSCREEN
]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_toggle_fullscreen"):
		current_window_mode += 1;
		current_window_mode %= 2;
		DisplayServer.window_set_mode(window_modes[current_window_mode])
