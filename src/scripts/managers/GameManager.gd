extends Node2D

const game_data: GameData = preload("res://data/game_data.tres")

var current_day_index: int = 0
var total_earnings: int = 0

var daily_report: DailyReport = null

func start_game() -> void:
	start_next_day()

func start_next_day() -> void:
	if current_day_index >= game_data.days.size():
		print("All days complete")
		return 
	
	var day = game_data.days[current_day_index]
	DayManager.start_day(day)
	DayManager.day_complete.connect(_on_day_complete, CONNECT_ONE_SHOT)

func _on_day_complete(results: Array[InterrogationResultData]) -> void:
	daily_report = DailyReport.create(results, total_earnings)
	daily_report.report_close.connect(_on_report_close, CONNECT_ONE_SHOT)
	get_tree().current_scene.add_child(daily_report)
	
func _on_report_close(earnings: int) -> void:
	daily_report.queue_free()
	total_earnings = earnings
	current_day_index += 1
	start_next_day()
