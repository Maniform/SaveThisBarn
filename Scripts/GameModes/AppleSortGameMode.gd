class_name AppleSortGameMode extends Node

class DifficultyValues:
	var ff_apple_delay:= 1 as float
	var celebration_spawner_delay:= 1 as float
	
	func _init(_ff_apple_delay, _celebration_spawner_delay):
		ff_apple_delay = _ff_apple_delay
		celebration_spawner_delay = _celebration_spawner_delay

@export_category("UI assets")
@export_group("Apples")
@export var apple_spawner: AppleSpawner
@export var apple_progress_bar: ProgressBar
@export var barrel_progress_bar: ProgressBar
@export_group("Flim and Flam")
@export var ff_apple_progress_bar: ProgressBar
@export var ff_barrel_progress_bar: ProgressBar
@export_category("Objectives")
@export var barrels_objective:= 5 as int
@export var apple_per_barrel:= 10 as int
@export var elementsToShowAfterDifficulty: Array[Control]
@export_category("Time's up")
@export var times_up_sprite: Sprite2D
@export var times_up_sound_effect: AudioStream
@export var show_results_button: Button
@export_category("Victory")
@export var victory_sound_effect: AudioStream
@export var victory_music: AudioStream
@export var celebration_spawner: CelebrationSpawner
@export_category("End scenes")
@export var win_scene: SceneManager.SCENE
@export var hard_win_scene: SceneManager.SCENE
@export var lose_scene: SceneManager.SCENE

var difficultyOverrides = {
	DifficultyChooser.Difficulty.EASY: DifficultyValues.new(0.5, 0.5),
	DifficultyChooser.Difficulty.NORMAL: DifficultyValues.new(0.3, 0.3),
	DifficultyChooser.Difficulty.HARD: DifficultyValues.new(0.2, 0.08),
	DifficultyChooser.Difficulty.HONOR: DifficultyValues.new(0.15, 0.03)
}

@onready var ff_timer:= $FFTimer as Timer
@onready var countdown:= $Countdown as Countdown

var apples:= 0 as int
var barrels:= 0 as int
var ff_apples:= 0 as int
var ff_barrels:= 0 as int

var ff_apple_delay:= 0.3 as float
var difficulty:= DifficultyChooser.Difficulty.NORMAL
var victory:= false as bool

# Called when the node enters the scene tree for the first time.
func _ready():
	apple_progress_bar.max_value = apple_per_barrel - 1
	barrel_progress_bar.max_value = barrels_objective
	ff_apple_progress_bar.max_value = apple_per_barrel - 1
	ff_barrel_progress_bar.max_value = barrels_objective
	
	apple_progress_bar.value = apples
	barrel_progress_bar.value = barrels
	ff_apple_progress_bar.value = ff_apples
	ff_barrel_progress_bar.value = ff_barrels
	
	ff_timer.timeout.connect(add_ff_apple)
	countdown.finished.connect(start)
	
	for elem in elementsToShowAfterDifficulty:
		elem.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func on_apple_thrown(is_good: bool):
	if is_good:
		if apple_spawner.is_current_apple_good():
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
			victory = true
			end()
	apple_progress_bar.value = apples

func remove_apple(number:= 1 as int):
	apples = max(0, apples - number)
	apple_progress_bar.value = apples

func add_ff_apple(number:= 1 as int):
	var is_good = randi_range(0, 1)
	if is_good:
		ff_apples += number
		if ff_apples == apple_per_barrel:
			ff_barrels += 1
			ff_apples -= apple_per_barrel
			ff_barrel_progress_bar.value = ff_barrels
			if ff_barrels == barrels_objective:
				end()
	ff_apple_progress_bar.value = ff_apples

func set_difficulty(_difficulty: DifficultyChooser.Difficulty):
	difficulty = _difficulty
	
	for elem in elementsToShowAfterDifficulty:
		elem.visible = true
	
	ff_apple_delay = difficultyOverrides[difficulty].ff_apple_delay
	celebration_spawner.object_generation_delay = difficultyOverrides[difficulty].celebration_spawner_delay
	start_countdown()

func start_countdown():
	countdown.start()

func start():
	countdown.queue_free()
	ff_timer.start(ff_apple_delay)
	player_controller.input_game_mode = PlayerController.INPUT_GAME_MODE.GAME

func end():
	if difficulty == DifficultyChooser.Difficulty.COUNT - 1 and victory:
		unlock_hard_save()
	ff_timer.stop()
	player_controller.input_game_mode = PlayerController.INPUT_GAME_MODE.NONE
	main_music.stop()
	times_up_sprite.visible = true
	sound_effect.stream = times_up_sound_effect
	sound_effect.finished.connect(end_sound_finished)
	sound_effect.play()

func end_sound_finished():
	sound_effect.finished.disconnect(end_sound_finished)
	show_results_button.visible = true

func show_results():
	times_up_sprite.visible = false
	if(victory):
		win()
	else:
		lose()

func win():
	celebration_spawner.activated = true
	sound_effect.stream = victory_sound_effect
	sound_effect.finished.connect(victory_sound_effect_finished)
	sound_effect.play()

func lose():
	scene_manager.goto(lose_scene)

func victory_sound_effect_finished():
	sound_effect.finished.disconnect(victory_sound_effect_finished)
	main_music.stream = victory_music
	main_music.loop = false
	main_music.finished.connect(victory_music_finished)
	main_music.play()

func victory_music_finished():
	main_music.finished.disconnect(victory_music_finished)
	main_music.loop = true
	if difficulty == DifficultyChooser.Difficulty.COUNT - 1:
		scene_manager.goto(hard_win_scene)
	else:
		scene_manager.goto(win_scene)

func unlock_hard_save():
	if not FileAccess.file_exists("user://savegame.save"):
		FileAccess.open("user://savegame.save", FileAccess.WRITE).close()
	var saveFile = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	if saveFile.is_open():
		var saveDict = {
			"Version": ProjectSettings.get_setting("application/config/version", "0"),
			"HardVictory": true
		}
		saveFile.store_var(saveDict)
		saveFile.close()
