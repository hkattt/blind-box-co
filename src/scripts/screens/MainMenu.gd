class_name MainMenu extends Node2D

signal main_menu_complete

const main_menu_scene: PackedScene = preload("res://scenes/screens/MainMenu.tscn")

static func create() -> MainMenu:
	var main_menu: MainMenu = main_menu_scene.instantiate()
	return main_menu

func _unhandled_input(event: InputEvent) -> void:
	if event.is_pressed():
		SoundManager.play_sound(SoundManager.Sound.CLICK)
		main_menu_complete.emit()
