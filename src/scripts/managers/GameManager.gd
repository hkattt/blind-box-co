extends Node2D

const game_data: GameData = preload("res://data/game_data.tres")

var current_day_index: int = 0

var intro: Intro = null
var daily_report: DailyReport = null

func start_game() -> void:
	_play_intro()

func _play_intro():
	intro = Intro.create()
	intro.intro_complete.connect(_on_intro_complete, CONNECT_ONE_SHOT)
	get_tree().current_scene.add_child(intro)

func _start_next_day() -> void:
	if current_day_index >= game_data.days.size():
		print("All days complete")
		return 
	
	var day = game_data.days[current_day_index]
	DayManager.start_day(day)
	DayManager.day_complete.connect(_on_day_complete, CONNECT_ONE_SHOT)

func _on_intro_complete() -> void:
	_start_next_day()

func _on_day_complete(results: Array[InterrogationResultData]) -> void:
	daily_report = DailyReport.create(results)
	daily_report.report_close.connect(_on_report_close, CONNECT_ONE_SHOT)
	get_tree().current_scene.add_child(daily_report)
	
func _on_report_close() -> void:
	daily_report.queue_free()
	current_day_index += 1
	_start_next_day()
