class_name GrannySmith extends AnimatedSprite2DViewportScaler

@export var good_sound: AudioStream
@export var bad_sound: AudioStream

var audio_player: AudioStreamPlayer

signal apple_thrown()
signal apple_thrown_choice(is_good: bool)

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	audio_player = find_child("AudioStreamPlayer")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super._process(delta)
	if Input.is_action_just_pressed("ui_left"):
		select_apple(false)
	elif Input.is_action_just_pressed("ui_right"):
		select_apple(true)

func select_apple(is_good: bool):
	if player_controller.input_game_mode == PlayerController.INPUT_GAME_MODE.GAME:
		if is_good:
			audio_player.stream = good_sound
			audio_player.play()
			stop()
			play("Good")
			apple_thrown_choice.emit(1)
			apple_thrown.emit()
		else:
			audio_player.stream = bad_sound
			audio_player.play()
			stop()
			play("Bad")
			apple_thrown_choice.emit(0)
			apple_thrown.emit()

func _on_animation_finished():
	play("Idle")
