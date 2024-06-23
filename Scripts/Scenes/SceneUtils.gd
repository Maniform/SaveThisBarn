class_name SceneUtils extends Node

@export var scenes_to_preload: Array[SceneManager.SCENE]

# Called when the node enters the scene tree for the first time.
func _ready():
	scene_manager.preload_scenes(scenes_to_preload)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
