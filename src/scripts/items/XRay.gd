class_name XRay extends Area2D

signal xray_used

@onready var sprite: Sprite2D = $Sprite2D
@onready var timer: Timer     = $Timer

var xray_texture: Texture2D       = preload("res://assets/images/items/x-ray/x-ray.png")
var xray_hover_texture: Texture2D = preload("res://assets/images/items/x-ray/x-ray-hover.png")

func _on_dragable_drag_start() -> void:
	sprite.texture = xray_hover_texture
	SoundManager.play_sound(SoundManager.Sound.POWER_ON)
	xray_used.emit()
	timer.start()
	
func _on_dragable_drag_end() -> void:
	sprite.texture = xray_texture
	timer.stop()
	SoundManager.stop_sound()
	
func _on_timer_timeout() -> void:
	SoundManager.play_sound(SoundManager.Sound.SCAN)
