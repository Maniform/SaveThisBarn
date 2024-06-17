class_name AppleSpawner extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	change()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func change():
	frame = randi_range(0, 1)
