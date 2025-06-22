extends Node2D

enum Sound {
	CLICK,
	STAMP,
	POWER_ON,
	METAL_DETECTOR
}

@onready var sound_player: AudioStreamPlayer2D = $SoundPlayer

@onready var click_sound: AudioStream          = preload("res://assets/sfx/click.mp3")
@onready var stamp_sound: AudioStream          = preload("res://assets/sfx/stamp.mp3")
@onready var power_on_sound: AudioStream       = preload("res://assets/sfx/power-on.mp3")
@onready var metal_detector_sound: AudioStream = preload("res://assets/sfx/metal-detector.mp3")

@onready var sounds: Dictionary = {
	Sound.CLICK:    	  click_sound,
	Sound.STAMP:   		  stamp_sound,
	Sound.POWER_ON: 	  power_on_sound,
	Sound.METAL_DETECTOR: metal_detector_sound
}

func _ready() -> void:
	pass

func play_sound(sound: Sound, volume_db: float = 0.0) -> void:
	if sound in sounds:
		var audio_stream: AudioStream = sounds[sound]
		sound_player.stop()
		sound_player.stream = audio_stream
		sound_player.set_volume_db(volume_db)
		sound_player.play()
