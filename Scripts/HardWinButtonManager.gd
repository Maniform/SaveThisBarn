class_name HardWinButtonManager extends Node

@export var hardWinButton: GoToSceneButton

# Called when the node enters the scene tree for the first time.
func _ready():
	if FileAccess.file_exists("user://savegame.save"):
		var saveFile = FileAccess.open("user://savegame.save", FileAccess.READ)
		if saveFile.is_open():
			var saveDict = saveFile.get_var()
			if saveDict is Dictionary:
				if saveDict.get("Version", "0") == ProjectSettings.get_setting("application/config/version", "invalid"):
					hardWinButton.visible = saveDict.get("HardVictory", false) as bool
			saveFile.close()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
