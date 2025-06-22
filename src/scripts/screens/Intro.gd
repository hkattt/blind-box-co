class_name Intro extends Node2D

signal intro_complete

@onready var text_box: TextBox = $TextBox

const intro_scene: PackedScene = preload("res://scenes/screens/Intro.tscn")

var speaker: String 
var line: String

static func create() -> Intro:
	var intro: Intro = intro_scene.instantiate()
	return intro

func _ready() -> void:
	DialogueManager.load_dialogues(DialogueManager.DialogueType.EXPOSITION, "intro")
	_set_text_box()
	
func _set_text_box():
	speaker = DialogueManager.get_speaker()
	line = DialogueManager.get_line()
	text_box.set_text(line)

func _on_next_button_pressed() -> void:
	if DialogueManager.is_finished():
		intro_complete.emit()
	else:
		DialogueManager.next_line()
		_set_text_box()
