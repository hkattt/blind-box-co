extends Node2D
	
enum GameScreen {
	MAIN_MENU,
	INTRO,
	DAY,
	INTERROGATION,
	REPORT,
	HIRED,
	REJECTED
}

@onready var screen_transition: ScreenTransition = $ScreenTransition

const game_data: GameData = preload("res://data/game_data.tres")

const HIRED_EARNINGS: int = 50

var game_screen: GameScreen = GameScreen.INTRO
var intro: Intro = null
var daily_report: DailyReport = null
var day: Day = null
var hired: Hired = null
var rejected: Rejected = null

var current_day_index: int = 0
var interrogation_results: Array[InterrogationResultData]

func _ready() -> void:
	MusicManager.play_music(MusicManager.Music.ELEVATOR)
	_start_game()
	
func _start_game() -> void:
	await _change_screen()

func _get_next_screen() -> GameScreen:
	match game_screen:
		GameScreen.INTRO:
			return GameScreen.DAY
		GameScreen.DAY:
			return GameScreen.INTERROGATION
		GameScreen.INTERROGATION:
			return GameScreen.REPORT
		GameScreen.REPORT:
			if current_day_index >= game_data.days.size():
				if ReportManager.get_total_earnings() > HIRED_EARNINGS:
					return GameScreen.HIRED
				else:
					return GameScreen.REJECTED
			else:
				return GameScreen.DAY
		GameScreen.HIRED, GameScreen.REJECTED:
			return GameScreen.MAIN_MENU
		_:
			return GameScreen.MAIN_MENU

func _change_screen() -> void:
	await screen_transition.fade_out()
	
	if intro:
		intro.queue_free()
	if day:
		day.queue_free()
	if daily_report:
		daily_report.queue_free()
	
	match game_screen:
		GameScreen.INTRO:
			intro = Intro.create()
			intro.intro_complete.connect(_on_intro_complete, CONNECT_ONE_SHOT)
			get_tree().current_scene.add_child(intro)
		GameScreen.DAY:
			day = Day.create(current_day_index + 1)
			day.day_timer_finished.connect(_on_day_timer_finished, CONNECT_ONE_SHOT)
			get_tree().current_scene.add_child(day)
		GameScreen.INTERROGATION:
			var day_data = game_data.days[current_day_index]
			DayManager.start_day(day_data, screen_transition)
			DayManager.day_complete.connect(_on_day_complete, CONNECT_ONE_SHOT)
		GameScreen.REPORT:
			daily_report = DailyReport.create(interrogation_results)
			daily_report.report_close.connect(_on_report_close, CONNECT_ONE_SHOT)
			get_tree().current_scene.add_child(daily_report)
		GameScreen.HIRED:
			hired = Hired.create()
			get_tree().current_scene.add_child(hired)
		GameScreen.REJECTED:
			rejected = Rejected.create()
			get_tree().current_scene.add_child(rejected)
	
	await screen_transition.fade_in()

func _on_intro_complete() -> void:
	game_screen = _get_next_screen()
	await _change_screen()
	
func _on_day_timer_finished() -> void:
	game_screen = _get_next_screen()
	await _change_screen()
	
func _on_day_complete(results: Array[InterrogationResultData]) -> void:
	interrogation_results = results
	current_day_index += 1
	game_screen = _get_next_screen()
	await _change_screen()
	
func _on_report_close() -> void:
	game_screen = _get_next_screen()
	await _change_screen()
