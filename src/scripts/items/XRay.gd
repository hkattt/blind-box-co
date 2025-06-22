class_name XRay extends Area2D

signal xray_used

func _on_dragable_drag_start() -> void:
	SoundManager.play_sound(SoundManager.Sound.POWER_ON)
	xray_used.emit()
