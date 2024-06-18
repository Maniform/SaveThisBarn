class_name AppleSpawners extends Node2D

var apple_spawners: Array[AppleSpawner]

# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		if child is AppleSpawner:
			apple_spawners.append(child)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func change():
	for i in range(0, apple_spawners.size() - 1):
		apple_spawners[i].frame = apple_spawners[i+1].frame
	apple_spawners[apple_spawners.size() - 1].change()
