class_name Character extends Node2D

signal document_received(approved: bool)

@onready var portrait = $Portrait

var dialogue_sound: SoundManager.Sound
var portrait_texture: Texture2D
var portrait_hover_texture: Texture2D
var hovered_document: Area2D = null

func load_character(character_data: CharacterData):
	portrait_texture = character_data.portrait
	portrait_hover_texture = character_data.portrait_hover
	portrait.texture = portrait_texture
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
		portrait.texture = portrait_hover_texture
		position.y -= 1
		hovered_document = area
		
func _on_area_exited(area: Area2D) -> void:
	if area.is_in_group("Documents") and area.is_signed():
		portrait.texture = portrait_texture
		position.y += 1
		hovered_document = null
	
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if hovered_document:
			SoundManager.play_sound(SoundManager.Sound.CRUNCH_PAPER)
			document_received.emit(hovered_document.is_approved())
			hovered_document.queue_free()
