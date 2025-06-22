extends Node2D

enum Sound {
	CLICK,
	STAMP,
	POWER_ON,
	METAL_DETECTOR,
	DIALOGUE1,
	DIALOGUE2,
	DIALOGUE3,
	DIALOGUE4,
	DIALOGUE5
}

@onready var sound_player: AudioStreamPlayer2D = $SoundPlayer

@onready var click_sound: AudioStream          = preload("res://assets/sfx/click.mp3")
@onready var stamp_sound: AudioStream          = preload("res://assets/sfx/stamp.mp3")
@onready var power_on_sound: AudioStream       = preload("res://assets/sfx/power-on.mp3")
@onready var metal_detector_sound: AudioStream = preload("res://assets/sfx/metal-detector.mp3")
@onready var dialogue1_sound: AudioStream      = preload("res://assets/sfx/dialogue-1.mp3")
@onready var dialogue2_sound: AudioStream      = preload("res://assets/sfx/dialogue-2.mp3")
@onready var dialogue3_sound: AudioStream      = preload("res://assets/sfx/dialogue-3.mp3")
@onready var dialogue4_sound: AudioStream      = preload("res://assets/sfx/dialogue-4.mp3")
@onready var dialogue5_sound: AudioStream      = preload("res://assets/sfx/dialogue-5.mp3")

@onready var sounds: Dictionary = {
	Sound.CLICK:    	  click_sound,
	Sound.STAMP:   		  stamp_sound,
	Sound.POWER_ON: 	  power_on_sound,
	Sound.METAL_DETECTOR: metal_detector_sound,
	Sound.DIALOGUE1:      dialogue1_sound,
	Sound.DIALOGUE2:      dialogue2_sound,
	Sound.DIALOGUE3:      dialogue3_sound,
	Sound.DIALOGUE4:      dialogue4_sound,
	Sound.DIALOGUE5:      dialogue5_sound
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
