class_name Hired extends Node2D

signal hired_complete

const hired_scene: PackedScene = preload("res://scenes/screens/Hired.tscn")

static func create() -> Hired:
	var hired: Hired = hired_scene.instantiate()
	return hired

func _ready() -> void:
	SoundManager.play_sound(SoundManager.Sound.VICTORY)

func _on_texture_button_pressed() -> void:
	hired_complete.emit()
