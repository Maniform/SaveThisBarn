extends Node

@export var barrels_objective:= 10 as int
@export var apple_per_barrel:= 10 as int

var apples:= 0 as int
var barrels:= 0 as int

signal apple_number_changed(apple_number: int)
signal barrel_number_changed(barrel_number: int)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func add_apples(number:= 1 as int):
	apples += number
	if apples == apple_per_barrel:
		apples -= apple_per_barrel
		barrels += 1
		barrel_number_changed.emit(barrels)
		if barrels == barrels_objective:
			win()
	apple_number_changed.emit(apples)

func remove_apple():
	apples = max(0, apples - 1)

func win():
	pass
