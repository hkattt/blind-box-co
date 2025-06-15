extends Node2D

@onready var portrait = $Portrait

func load_character(character_data: CharacterData):
	portrait.texture = character_data.portrait
