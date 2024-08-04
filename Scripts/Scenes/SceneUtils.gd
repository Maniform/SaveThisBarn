class_name SceneUtils extends Node

@export var scenes_to_preload: Array[SceneManager.SCENE]

# Called when the node enters the scene tree for the first time.
func _ready():
	#TranslationServer.set_locale("en") #Force la langue pour des tests
	scene_manager.preload_scenes(scenes_to_preload)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
