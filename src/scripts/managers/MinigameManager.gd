extends Node

var minigame_scene: PackedScene = preload("res://scenes/InterrogationMinigame.tscn")

var current_minigame: Node2D = null

func start_interrogation(character_data: CharacterData, package_data: PackageData):
	if current_minigame:
		current_minigame.queue_free()
		
	var minigame: Node2D = minigame_scene.instantiate()
	get_tree().current_scene.add_child(minigame)
	
	minigame.setup(character_data, package_data)
	minigame.connect("interrogation_complete", _on_interrogation_complete)
	current_minigame = minigame

func _on_interrogation_complete():
	print("Interrogation complete handled.")
