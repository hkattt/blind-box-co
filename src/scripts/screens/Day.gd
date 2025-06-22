class_name Day extends Node2D

signal day_timer_finished

@onready var day_text_label: Label = $CenterContainer/DayText
@onready var timer: Timer          = $Timer

const day_scene: PackedScene = preload("res://scenes/screens/Day.tscn")

var day_number: int = 1

func _ready() -> void:
	day_text_label.text = "Day " + str(day_number)
	timer.start(3.0)

static func create(p_day_number: int) -> Day:
	var day: Day = day_scene.instantiate()
	day.day_number = p_day_number
	return day

func _on_timer_timeout() -> void:
	day_timer_finished.emit()
