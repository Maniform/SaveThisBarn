class_name AppleSortGameMode extends Node

class DifficultyValues:
	var ff_apple_delay:= 1 as float
	var celebration_spawner_delay:= 1 as float
	
	func _init(_ff_apple_delay, _celebration_spawner_delay):
		ff_apple_delay = _ff_apple_delay
		celebration_spawner_delay = _celebration_spawner_delay

@export var barrels_objective:= 5 as int
@export var apple_per_barrel:= 10 as int
@export var apple_spawner: AppleSpawner
@export var apple_progress_bar: ProgressBar
@export var barrel_progress_bar: ProgressBar
@export var ff_apple_progress_bar: ProgressBar
@export var ff_barrel_progress_bar: ProgressBar
@export var ff_apple_delay:= 1 as float
@export var celebration_spawner: CelebrationSpawner
@export var victory_sound_effect: AudioStream
@export var victory_music: AudioStream
@export var win_scene: SceneManager.SCENE
@export var lose_scene: SceneManager.SCENE

@export var elementsToShowOnDifficulty: Array[Control]
var difficultyOverrides = {
	DifficultyChooser.Difficulty.EASY: DifficultyValues.new(0.5, 0.5),
	DifficultyChooser.Difficulty.NORMAL: DifficultyValues.new(0.3, 0.3),
	DifficultyChooser.Difficulty.HARD: DifficultyValues.new(0.2, 0.08)
}

@onready var ff_timer:= $FFTimer as Timer
@onready var countdown:= $Countdown as Countdown

var apples:= 0 as int
var barrels:= 0 as int
var ff_apples:= 0 as int
var ff_barrels:= 0 as int

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
	
	for elem in elementsToShowOnDifficulty:
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
			win()
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
				lose()
	ff_apple_progress_bar.value = ff_apples

func set_difficulty(difficulty: DifficultyChooser.Difficulty):
	for elem in elementsToShowOnDifficulty:
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

func win():
	ff_timer.stop()
	player_controller.input_game_mode = PlayerController.INPUT_GAME_MODE.NONE
	celebration_spawner.activated = true
	main_music.stop()
	sound_effect.stream = victory_sound_effect
	sound_effect.finished.connect(victory_sound_effect_finished)
	sound_effect.play()

func lose():
	ff_timer.stop()
	player_controller.input_game_mode = PlayerController.INPUT_GAME_MODE.NONE
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
	scene_manager.goto(win_scene)
