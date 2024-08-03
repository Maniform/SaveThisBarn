class_name DifficultyChooser extends Control

@export var difficultyButtons: Array[DifficultyButton]

signal difficulty_selected(value: float)

# Called when the node enters the scene tree for the first time.
func _ready():
	for difficultyButton in difficultyButtons:
		difficultyButton.difficulty_selected.connect(select_difficutly)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func select_difficutly(value: float):
	difficulty_selected.emit(value)
	queue_free()
