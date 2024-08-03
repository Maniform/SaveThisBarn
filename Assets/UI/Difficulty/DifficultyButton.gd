class_name DifficultyButton extends Button

@export var difficulty:= DifficultyChooser.Difficulty.NORMAL as DifficultyChooser.Difficulty

signal difficulty_selected(difficulty: DifficultyChooser.Difficulty)

# Called when the node enters the scene tree for the first time.
func _ready():
	pressed.connect(send_difficulty)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func send_difficulty():
	difficulty_selected.emit(difficulty)
