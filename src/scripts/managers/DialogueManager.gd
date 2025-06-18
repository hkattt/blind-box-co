extends Node

var dialogue_index: int = 0
var dialogue_lines: Array = []

enum DialogueType {
	CONVERSATION,
	EXPOSITION 
}
	
func load_dialogues(type: DialogueType, dialogue_name) -> void:
	var type_directory = get_dialogue_type_directory(type)
		
	var file_path = "res://dialogues/{type_directory}/{dialogue_name}.json".format({
		"type_directory": type_directory, 
		"dialogue_name": dialogue_name
	})
	
	if not FileAccess.file_exists(file_path):
		push_error("Dialogue file not found: " + file_path)
		return 
		
	var json_as_text: String = FileAccess.get_file_as_string(file_path)
	var json_as_dict: Dictionary = JSON.parse_string(json_as_text)
	
	# Set the dialogue lines
	dialogue_lines = json_as_dict["lines"]
	
func next_line() -> void:
	dialogue_index += 1
	
func get_speaker() -> String:
	return dialogue_lines[dialogue_index]["speaker"]

func get_line() -> String:
	return dialogue_lines[dialogue_index]["line"]
	
func get_dialogue_type_directory(type: DialogueType) -> String:
	match type:
		DialogueType.CONVERSATION:
			return "conversations"
		DialogueType.EXPOSITION:
			return "exposition"
		# Cannot be reached
		_:
			return "invalid"
