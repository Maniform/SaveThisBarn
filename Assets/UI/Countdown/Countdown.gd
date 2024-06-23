class_name Countdown extends Node2D

@export var start_size:= 0 as float
@export var end_size:= 100 as float
@export var values: Array[String]
@export var step_time:= 1 as float
@export var end_step_time:= 0.5 as float

@onready var label:= $Label as Label
@onready var timer:= $Timer as Timer
@onready var end_step_timer:= $EndStepTimer as Timer
@onready var audio_stream_player:= $AudioStreamPlayer as AudioStreamPlayer

var index:= 0 as int
var value: String

signal stepped(value: int)
signal end_stepped(value: int)
signal finished()

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.one_shot = true
	end_step_timer.one_shot = true
	timer.timeout.connect(step)
	end_step_timer.timeout.connect(end_step)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not timer.is_stopped():
		var size_override = lerp(start_size, end_size, (timer.wait_time - timer.time_left) / timer.wait_time)
		set_label_size(size_override)

func start():
	value = values[index]
	label.text = str(value)
	timer.start(step_time)

func step():
	set_label_size(end_size)
	stepped.emit(value)
	end_step_timer.start(end_step_time)

func end_step():
	index += 1
	if index < values.size():
		value = values[index]
		set_label_size(start_size)
		label.text = str(value)
		timer.start(step_time)
		end_stepped.emit(value)
	else:
		finished.emit()

func set_label_size(size_override: float):
	label.set("theme_override_font_sizes/font_size", size_override)
