class_name SceneManager extends Node

enum SCENE {MAIN_MENU, GRANNY_SMITH, LOSE}

var scenes = [
	"res://Scenes/MainMenu.tscn",
	"res://Scenes/GrannySmith.tscn",
	"res://Scenes/Lose.tscn"
] as Array[String]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func get_scene(scene: SCENE):
	return scenes[scene]

func goto(scene: SCENE):
	get_tree().change_scene_to_file(scenes[scene])
