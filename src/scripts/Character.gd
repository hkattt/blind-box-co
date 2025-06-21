class_name Character extends Node2D

signal document_received(approved: bool)

@onready var portrait = $Portrait

func load_character(character_data: CharacterData):
	portrait.texture = character_data.portrait

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Documents") and area.is_signed():
		document_received.emit(area.is_approved())
		area.queue_free()
