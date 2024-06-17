extends AudioStreamPlayerLoop

var music_stream = null

func _ready():
	super._ready()
	play_music("res://Sounds/Music/Ponytune – Raise This Barn 8-bit.wav")

func play_music(music_path: String):
	music_stream = load(music_path)
	bus = "Music"
	stream = music_stream
	play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
