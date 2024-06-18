class_name AppleSortGameMode extends Node

@export var barrels_objective:= 5 as int
@export var apple_per_barrel:= 10 as int
@export var current_apple_spawner: AppleSpawner
@export var apple_progress_bar: ProgressBar
@export var barrel_progress_bar: ProgressBar
@export var celebration_spawner: CelebrationSpawner
@export var victory_sound_effect: AudioStream
@export var victory_music: AudioStream

var apples:= 0 as int
var barrels:= 0 as int

# Called when the node enters the scene tree for the first time.
func _ready():
	apple_progress_bar.max_value = apple_per_barrel
	barrel_progress_bar.max_value = barrels_objective
	player_controller.input_game_mode = PlayerController.INPUT_GAME_MODE.GAME

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func on_apple_thrown(is_good: bool):
	if is_good:
		if current_apple_spawner.is_apple_good():
			add_apple()
		else:
			remove_apple()

func add_apple(number:= 1 as int):
	apples += number
	if apples == apple_per_barrel:
		apples -= apple_per_barrel
		barrels += 1
		barrel_progress_bar.value = barrels
		if barrels == barrels_objective:
			win()
	apple_progress_bar.value = apples

func remove_apple(number:= 1 as int):
	apples = max(0, apples - number)
	apple_progress_bar.value = apples

func win():
	player_controller.input_game_mode = PlayerController.INPUT_GAME_MODE.UI
	celebration_spawner.activated = true
	main_music.stop()
	sound_effect.stream = victory_sound_effect
	sound_effect.finished.connect(victory_sound_effect_finished)
	sound_effect.play()

func victory_sound_effect_finished():
	sound_effect.finished.disconnect(victory_sound_effect_finished)
	main_music.stream = victory_music
	main_music.loop = false
	main_music.finished.connect(victory_music_finished)
	main_music.play()

func victory_music_finished():
	main_music.finished.disconnect(victory_music_finished)
	main_music.loop = true
	main_music.play_music(main_music.default_music)
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")
