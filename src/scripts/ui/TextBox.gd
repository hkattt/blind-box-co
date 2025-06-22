class_name TextBox extends PanelContainer

const CHARACTER_READ_RATE: float = 0.05

@onready var text: Label  = $MarginContainer/Text
@onready var timer: Timer = $Timer

var tween: Tween = create_tween()
var dialoge_sound: SoundManager.Sound

func hide_text_box() -> void:
	text.text = ""
	hide()
	
func show_text_box() -> void:
	show()
	
func set_dialogue_sound(p_dialogue_sound: SoundManager.Sound) -> void:
	dialoge_sound = p_dialogue_sound

func set_text(new_text: String) -> void:
	text.text = new_text
	text.visible_ratio = 0.0
	show_text_box()
	
	if dialoge_sound:
		SoundManager.play_sound(dialoge_sound, -10.0)
		timer.start()
	
	tween.stop()
	tween = create_tween()
	tween.tween_property(text, "visible_ratio", 1.0, len(new_text) * CHARACTER_READ_RATE)
	tween.finished.connect(_on_text_fully_displayed, CONNECT_ONE_SHOT)

func _on_text_fully_displayed() -> void:
	timer.stop()	

func _on_timer_timeout() -> void:
	SoundManager.play_sound(dialoge_sound, -10.0)
