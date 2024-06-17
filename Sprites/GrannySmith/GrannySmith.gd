class_name GrannySmith extends AnimatedSprite2D

@export var good_sound: AudioStream
@export var bad_sound: AudioStream

var audio_player: AudioStreamPlayer
var viewport_scaler: AnimatedSprite2DViewportScaler

signal apple_thrown()
signal apple_thrown_choice(is_good: bool)

# Called when the node enters the scene tree for the first time.
func _ready():
	audio_player = find_child("AudioStreamPlayer")
	viewport_scaler = find_child("AnimatedSprite2DViewportScaler")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_left"):
		select_apple(false)
	elif Input.is_action_just_pressed("ui_right"):
		select_apple(true)

func select_apple(is_good: bool):
	if is_good:
		audio_player.stream = good_sound
		audio_player.play()
		stop()
		play("Good")
		apple_thrown.emit()
		apple_thrown_choice.emit(1)
	else:
		audio_player.stream = bad_sound
		audio_player.play()
		stop()
		play("Bad")
		apple_thrown.emit()
		apple_thrown_choice.emit(0)

func _on_animation_finished():
	play("Idle")
