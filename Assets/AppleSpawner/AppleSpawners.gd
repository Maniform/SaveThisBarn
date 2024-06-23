class_name AppleSpawners extends Node2D

@export_range(0, 1) var bad_apple_rate:= 0.5 as float

var apple_spawners: Array[Sprite2D]

# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		if child is Sprite2D:
			apple_spawners.append(child)
			child.frame = generate_apple()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func is_current_apple_good() -> bool:
	return bool(!apple_spawners[0].frame)

func generate_apple() -> int:
	return randf() < bad_apple_rate

func change():
	for i in range(0, apple_spawners.size() - 1):
		apple_spawners[i].frame = apple_spawners[i+1].frame
	var bad_apple = generate_apple()
	apple_spawners[apple_spawners.size() - 1].frame = bad_apple
