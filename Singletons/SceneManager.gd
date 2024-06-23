class_name SceneManager extends Node

enum SCENE {MAIN_MENU, GRANNY_SMITH, LOSE}

var scenes = [
	"res://Scenes/MainMenu.tscn",
	"res://Scenes/GrannySmith.tscn",
	"res://Scenes/Lose.tscn"
] as Array[StringName]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func get_scene(scene: SCENE) -> String:
	return scenes[scene]

func goto(scene: SCENE):
	var preloaded_scene = ResourceLoader.load_threaded_get(scenes[scene])
	if preloaded_scene != null:
		get_tree().change_scene_to_packed(preloaded_scene)
	else:
		get_tree().change_scene_to_file(scenes[scene])

func preload_scene(scene_to_load: SCENE):
	ResourceLoader.load_threaded_request(scenes[scene_to_load])

func preload_scenes(scenes_to_load: Array[SCENE]):
	for scene_to_load in scenes_to_load:
		ResourceLoader.load_threaded_request(scenes[scene_to_load])
