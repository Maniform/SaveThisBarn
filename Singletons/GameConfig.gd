extends Node

var config = ConfigFile.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	var error = config.load("user://game_config.cfg")
	if error == OK:
		load_config()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		save_congig()

func load_config():
	for audio_bus_index in range(0,AudioServer.bus_count - 1):
		var audio_bus_name = AudioServer.get_bus_name(audio_bus_index)
		var volume_db = config.get_value(audio_bus_name, "Volume")
		AudioServer.set_bus_volume_db(audio_bus_index, volume_db)
		
func save_congig():
	for audio_bus_index in range(0,AudioServer.bus_count - 1):
		var audio_bus_name = AudioServer.get_bus_name(audio_bus_index)
		var volume_db = AudioServer.get_bus_volume_db(audio_bus_index)
		config.set_value(audio_bus_name, "Volume", volume_db)
	
	config.save("user://game_config.cfg")
