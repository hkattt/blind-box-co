class_name SpeechBubble extends Control

@onready var label: Label = $MarginContainer/Label

const speech_bubble_scene: PackedScene = preload("res://scenes/ui/SpeechBubble.tscn")
	
func set_text(text: String):
	label.text = text
	
func fade_out():
	var tween = create_tween()
	tween.tween_property(self, "position:y", -50, 1.0)

func fade_in():
	pass
