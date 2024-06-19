class_name GoToSceneButton extends Button

@export var scene: SceneManager.SCENE

# Called when the node enters the scene tree for the first time.
func _ready():
	pressed.connect(_on_pressed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	scene_manager.goto(scene)
