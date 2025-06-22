extends Node

signal day_complete(results: InterrogationResultData)

var interrogation_scene: PackedScene = preload("res://scenes/screens/Interrogation.tscn")

var current_interrogation: Node2D = null
var interrogation_queue: Array[InterrogationData] = []
var interrogation_results: Array[InterrogationResultData] = []
var screen_transition: ScreenTransition

func start_day(day_data: DayData, p_screen_transition: ScreenTransition) -> void:
	interrogation_queue = day_data.interrogations
	screen_transition = p_screen_transition
	process_next_interrogation()

func process_next_interrogation() -> void:
	await  screen_transition.fade_out()
	
	# Free the current interrogation, if it exists
	if current_interrogation:
		current_interrogation.queue_free()
		current_interrogation = null 
		
	if interrogation_queue.is_empty():
		day_complete.emit(interrogation_results)
		interrogation_results = []
		print('DayManager: All interrogations complete')
		return
	
	var interrogation_data = interrogation_queue.pop_front()
	# Create a new interrogation instance
	current_interrogation = interrogation_scene.instantiate()
	# Add the new interrogation. Defer the call to allow everything to finish
	call_deferred("_add_interrogation", interrogation_data)

func _add_interrogation(interrogation_data: InterrogationData) -> void:
	get_tree().current_scene.add_child(current_interrogation)
	# Populate with the interrogation data 
	current_interrogation.setup(interrogation_data.character, interrogation_data.package)
	current_interrogation.interrogation_complete.connect(_on_interrogation_complete, CONNECT_ONE_SHOT)
	await  screen_transition.fade_in()

func _on_interrogation_complete(result: InterrogationResultData) -> void:
	interrogation_results.append(result)
	process_next_interrogation()
