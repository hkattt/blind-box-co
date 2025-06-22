class_name XRay extends Area2D

signal xray_used

@onready var timer: Timer = $Timer

func _on_dragable_drag_start() -> void:
	SoundManager.play_sound(SoundManager.Sound.POWER_ON)
	xray_used.emit()
	timer.start()
	
func _on_dragable_drag_end() -> void:
	timer.stop()
	SoundManager.stop_sound()
	
func _on_timer_timeout() -> void:
	SoundManager.play_sound(SoundManager.Sound.SCAN)
