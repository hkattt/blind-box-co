extends Node

var interrogation_scene: PackedScene = preload("res://scenes/Interrogation.tscn")

var current_interrogation: Node2D = null

func start_interrogation(character_data: CharacterData, package_data: PackageData):
	if current_interrogation:
		current_interrogation.queue_free()
		
	var interrogation: Node2D = interrogation_scene.instantiate()
	get_tree().current_scene.add_child(interrogation)
	
	interrogation.setup(character_data, package_data)
	interrogation.connect("interrogation_complete", _on_interrogation_complete)
	current_interrogation = interrogation

func _on_interrogation_complete():
	print("Interrogation complete handled.")
