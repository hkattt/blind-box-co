extends Node

signal interrogation_complete

@onready var character_slot: Control = $CharacterSlot
@onready var package_slot: Control   = $PackageSlot

var character_scene: PackedScene = preload("res://scenes/Character.tscn")
var package_scene: PackedScene   = preload("res://scenes/Package.tscn")

func setup(character_data: CharacterData, package_data: PackageData):
	var character: Node2D = character_scene.instantiate()
	character_slot.add_child(character)
	character.load_character(character_data)
	
	var package: Node2D = package_scene.instantiate()
	package_slot.add_child(package)
	package.load_package(package_data)

func _on_approve_button_pressed() -> void:
	print('Interrogation: Interrogation complete')
	interrogation_complete.emit()
