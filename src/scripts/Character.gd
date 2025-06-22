class_name Character extends Node2D

signal document_received(approved: bool)

@onready var portrait = $Portrait

var dialogue_sound: SoundManager.Sound

func load_character(character_data: CharacterData):
	portrait.texture = character_data.portrait
	dialogue_sound = number_to_dialogue_sound(character_data.dialoge_sound)

func number_to_dialogue_sound(dialogue_number: int):
	match dialogue_number:
		1: 
			return SoundManager.Sound.DIALOGUE1
		2:
			return SoundManager.Sound.DIALOGUE2
		3:
			return SoundManager.Sound.DIALOGUE3
		4:
			return SoundManager.Sound.DIALOGUE4
		5:
			return SoundManager.Sound.DIALOGUE5

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Documents") and area.is_signed():
		SoundManager.play_sound(SoundManager.Sound.CRUNCH_PAPER)
		document_received.emit(area.is_approved())
		area.queue_free()
