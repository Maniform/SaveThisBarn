class_name CelebrationSpawner extends Node

@export var objects: Dictionary
@export var activated:= false as bool
@export var object_generation_delay:= 0.1 as float
@export var speed_factor = Vector3(1, 1, 1)

var celebration_textures: Array[Texture2D]
var celebration_objects_rate: Array[float]
var celebration_objects_max_rate:= 0 as float
var time:= 0 as float

# Called when the node enters the scene tree for the first time.
func _ready():
	for texture in objects.keys():
		if texture is Texture2D:
			celebration_textures.append(texture)
	for rate in objects.values():
		if rate is float:
			celebration_objects_rate.append(rate)
			celebration_objects_max_rate += rate

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if activated:
		time += delta
		while time >= object_generation_delay:
			time -= object_generation_delay
			var rvalue = randf_range(0, celebration_objects_max_rate)
			var index = 0
			for rate in celebration_objects_rate:
				rvalue -= rate
				if rvalue <= 0:
					break
				index += 1
			var celebration_object = CelebrationObject.new(speed_factor)
			celebration_object.texture = celebration_textures[index]
			get_tree().root.add_child(celebration_object)
