extends Node2D

signal document_received

@onready var portrait = $Portrait

func load_character(character_data: CharacterData):
	portrait.texture = character_data.portrait

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Documents"):
		area.queue_free()
		document_received.emit()
