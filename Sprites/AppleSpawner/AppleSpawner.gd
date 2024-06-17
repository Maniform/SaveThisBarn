class_name AppleSpawner extends AnimatedSprite2D

@export var bad_apple_rate := 0.5 as float

# Called when the node enters the scene tree for the first time.
func _ready():
	change()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_apple_state(is_good: bool):
	frame = !is_good

func change():
	set_apple_state(randf() > bad_apple_rate)
