extends CheckBox


# Called when the node enters the scene tree for the first time.
func _ready():
	set_checkbox_state(player_controller.fullscreen)
	player_controller.fullscreen_state_changed.connect(set_checkbox_state)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_checkbox_state(enabled: bool):
	button_pressed = enabled

func _on_toggled(toggled_on):
	player_controller.set_fullscreen(toggled_on)
