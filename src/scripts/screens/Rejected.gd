class_name Rejected extends Node2D

signal rejected_complete

const rejected_scene: PackedScene = preload("res://scenes/screens/Rejected.tscn")

static func create() -> Rejected:
	var rejected: Rejected = rejected_scene.instantiate()
	return rejected

func _ready() -> void:
	SoundManager.play_sound(SoundManager.Sound.FAILURE, -5.0)


func _on_texture_button_pressed() -> void:
	rejected_complete.emit()
