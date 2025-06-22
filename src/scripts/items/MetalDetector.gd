class_name MetalDetector extends Area2D

signal metal_detector_used

enum MetalDetectorState {
	ON,
	OFF,
	FLASHING
}

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var timer: Timer                      = $Timer

var state: MetalDetectorState = MetalDetectorState.OFF

func _ready() -> void:
	_update_from_state()

func _on_dragable_drag_start() -> void:
	state = MetalDetectorState.ON
	SoundManager.play_sound(SoundManager.Sound.POWER_ON)
	_update_from_state()

func _on_dragable_drag_end() -> void:
	state = MetalDetectorState.OFF
	_update_from_state()

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Packages") and area.get_has_metal():
		state = MetalDetectorState.FLASHING
		metal_detector_used.emit()
	_update_from_state()	

func _on_area_exited(area: Area2D) -> void:
	if area.is_in_group("Packages"):
		state = MetalDetectorState.ON
	_update_from_state()

func _update_from_state():
	animated_sprite.stop()
	
	match state:
		MetalDetectorState.OFF:
			animated_sprite.animation = "Off"
			SoundManager.stop_sound()
			timer.stop()
		MetalDetectorState.ON:
			animated_sprite.animation = "On"
			timer.stop()
		MetalDetectorState.FLASHING:
			animated_sprite.animation = "Flash"
			SoundManager.play_sound(SoundManager.Sound.METAL_DETECTOR, 20.0)
			timer.start(3.0)
			
	animated_sprite.play()

func _on_timer_timeout() -> void:
	SoundManager.play_sound(SoundManager.Sound.METAL_DETECTOR, 20.0)
