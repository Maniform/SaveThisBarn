class_name Sprite2DViewportScaler extends Sprite2D

var size: Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	get_viewport().size_changed.connect(adjust_size)
	adjust_size()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func adjust_size():
	size = get_rect().size
	var new_scale := get_viewport_rect().size / size as Vector2
	var min_value := min(new_scale.x, new_scale.y) as float
	scale = Vector2(min_value, min_value)
