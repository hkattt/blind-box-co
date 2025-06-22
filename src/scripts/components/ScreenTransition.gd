class_name ScreenTransition extends CanvasLayer

@onready var background: ColorRect = $Background 

const fade_rate: float = 1.0

func _ready() -> void:
	background.mouse_filter = Control.MOUSE_FILTER_IGNORE
	background.modulate.a = 1.0

func fade_out() -> void:
	var tween: Tween = create_tween()
	tween.tween_property(background, "modulate:a", 1.0, fade_rate)
	await tween.finished

func fade_in() -> void:
	var tween: Tween = create_tween()
	tween.tween_property(background, "modulate:a", 0.0, fade_rate)
	await tween.finished
