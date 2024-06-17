extends HSlider

@export var audio_bus_name: StringName

const mute_db = -35

var audio_bus_index: int
var is_dragging = false

# Called when the node enters the scene tree for the first time.
func _ready():
	audio_bus_index = AudioServer.get_bus_index(audio_bus_name)
	min_value = mute_db
	max_value = 0
	value = AudioServer.get_bus_volume_db(audio_bus_index)
	drag_started.connect(_on_drag_started)
	drag_ended.connect(_on_drag_ended)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_dragging:
		AudioServer.set_bus_volume_db(audio_bus_index, value)
		if value <= mute_db:
			AudioServer.set_bus_mute(audio_bus_index, true)
		elif AudioServer.is_bus_mute(audio_bus_index):
			AudioServer.set_bus_mute(audio_bus_index, false)

func _on_drag_started():
	is_dragging = true
	
func _on_drag_ended(value_changed: bool):
	is_dragging = false
