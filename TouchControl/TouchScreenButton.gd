class_name HalfScreenButton extends TouchScreenButton

@export var emit_value: int

signal pressed_direction(direction: Variant)

# Called when the node enters the scene tree for the first time.
func _ready():
	if OS.get_name() == "Android":
		visible = true
	pressed.connect(_pressed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _pressed():
	pressed_direction.emit(emit_value)
