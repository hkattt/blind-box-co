extends Node

var minigame_scene: PackedScene = preload("res://scenes/InterrogationMinigame.tscn")

var current_minigame: Node2D = null

func start_interrogation(character_data: CharacterData, bag_data: PackageData):
	if current_minigame:
		current_minigame.queue_free()
		
	var minigame = minigame_scene.instantiate()
	get_tree().current_scene.add_child(minigame)
	
	minigame.setup(character_data, bag_data)
	current_minigame = minigame
