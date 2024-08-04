class_name MainMusicPlayer extends Node

@export var stream: AudioStream
@export var loop:= true as bool
@export var volume:= 1 as float

# Called when the node enters the scene tree for the first time.
func _ready():
	main_music.stream = stream
	main_music.loop = loop
	main_music.volume_db = volume
	main_music.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
