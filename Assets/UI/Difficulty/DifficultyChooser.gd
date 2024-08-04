class_name DifficultyChooser extends CenterContainer

enum Difficulty { EASY, NORMAL, HARD }

@export var difficultyButtons: Array[DifficultyButton]

signal difficulty_selected(difficulty: Difficulty)

# Called when the node enters the scene tree for the first time.
func _ready():
	for difficultyButton in difficultyButtons:
		difficultyButton.difficulty_selected.connect(select_difficutly)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func select_difficutly(difficulty: Difficulty):
	difficulty_selected.emit(difficulty)
	queue_free()
