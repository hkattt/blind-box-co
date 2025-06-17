class_name Conversation extends Node

@onready var speech_bubble_1: SpeechBubble = $SpeechBubble1
@onready var speech_bubble_2: SpeechBubble = $SpeechBubble2

var current_bubble = null

func _ready() -> void:
	speech_bubble_1.hide()
	speech_bubble_2.hide()

func load_conversation(conversation_name: String) -> void:
	DialogueManager.load_dialogues(DialogueManager.DialogueType.CONVERSATION, conversation_name)
	current_bubble = speech_bubble_1
	var line = DialogueManager.get_line()
	current_bubble.set_text(line)
	
func start() -> void:
	speech_bubble_1.show()
	speech_bubble_2.show()
	
func next_line() -> void:
	switch_bubble()
	DialogueManager.next_line()
	var line = DialogueManager.get_line()
	current_bubble.set_text(line)

func switch_bubble() -> void:
	current_bubble = speech_bubble_2 if current_bubble == speech_bubble_1 else speech_bubble_1


func _on_next_button_pressed() -> void:
	next_line()
