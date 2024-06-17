class_name OpenSubMenuButton extends Button

@export var nodes_to_hide: Array[Control]
@export var submenu_to_open: SubMenu

# Called when the node enters the scene tree for the first time.
func _ready():
	submenu_to_open.closed.connect(on_submenu_closed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func on_pressed():
	for node_to_hide in nodes_to_hide:
		node_to_hide.visible = false
	submenu_to_open.open()

func on_submenu_closed():
	for node_to_hide in nodes_to_hide:
		node_to_hide.visible = true
