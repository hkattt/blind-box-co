extends Node2D

var character: CharacterData = preload("res://data/characters/temp.tres")
var package: PackageData     = preload("res://data/packages/temp.tres")

func _ready() -> void:
	InterrogationManager.start_interrogation(character, package)
