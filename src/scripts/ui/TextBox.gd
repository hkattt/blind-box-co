class_name TextBox extends PanelContainer

const CHARACTER_READ_RATE: float = 0.05

@onready var text: Label         = $MarginContainer/Text

@onready var tween: Tween = create_tween()

func hide_text_box() -> void:
	text.text = ""
	hide()
	
func show_text_box() -> void:
	show()

func set_text(new_text: String) -> void:
	text.text = new_text
	text.visible_ratio = 0.0
	show_text_box()
	
	tween.stop()
	tween = create_tween()
	tween.tween_property(text, "visible_ratio", 1.0, len(new_text) * CHARACTER_READ_RATE)	
