extends Node2D

const game_data: GameData = preload("res://data/game_data.tres")

var current_day_index: int = 0

func start_game() -> void:
	start_next_day()

func start_next_day() -> void:
	if current_day_index >= game_data.days.size():
		print("All days complete")
		return 
	
	var day = game_data.days[current_day_index]
	DayManager.start_day(day)
	DayManager.day_complete.connect(_on_day_complete, CONNECT_ONE_SHOT)

func _on_day_complete() -> void:
	current_day_index += 1
	start_next_day()
