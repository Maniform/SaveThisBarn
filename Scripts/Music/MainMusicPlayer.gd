class_name MainMusicPlayer extends Node

@export var stream: AudioStream
@export var loop:= true as bool

# Called when the node enters the scene tree for the first time.
func _ready():
	main_music.stream = stream
	main_music.loop = loop
	main_music.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
