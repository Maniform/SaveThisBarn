class_name AudioStreamPlayerLoop extends AudioStreamPlayer

var loop:= true as bool

# Called when the node enters the scene tree for the first time.
func _ready():
	finished.connect(_on_finished)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_finished():
	if loop:
		play()
