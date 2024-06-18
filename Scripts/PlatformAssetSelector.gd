class_name PlatformAssetSelector extends SubMenu

enum PLATFORM {WINDOWS, ANDROID}

var platform_string:= ["Windows", "Android"] as Array[String]

@export var WindowsAsset: CanvasItem
@export var AndroidAsset: CanvasItem

# Called when the node enters the scene tree for the first time.
func _ready():
	if OS.get_name() != platform_string[PLATFORM.WINDOWS]:
		WindowsAsset.visible = false
	if OS.get_name() != platform_string[PLATFORM.ANDROID]:
		AndroidAsset.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
