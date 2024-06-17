extends Sprite2D

var viewport_scaler: Sprite2DViewportScaler

# Called when the node enters the scene tree for the first time.
func _ready():
	viewport_scaler = Sprite2DViewportScaler.new(self)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
