class_name CelebrationObject extends Sprite2D

var gravity:= 500 as float
var speed: Vector2
var angle_speed: float
var y_start: float
var y_trigger: float
var scale_value:= 0.2 as float

# Called when the node enters the scene tree for the first time.
func _ready():
	y_start = get_viewport_rect().size.y / 2 + 100
	y_trigger = get_viewport_rect().size.y / 2 + 200
	var half_viewport_size_x = get_viewport_rect().size.x / 2
	position = Vector2(randf_range(-half_viewport_size_x, half_viewport_size_x), y_start)
	speed.x = randf_range(-500, 500)
	speed.y = randf_range(-300, -1000)
	angle_speed = randf_range(-1, 1)
	scale = Vector2(scale_value, scale_value)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += speed * delta
	speed.y += gravity * delta
	rotate(angle_speed * delta)
	if position.y > y_trigger:
		queue_free()
