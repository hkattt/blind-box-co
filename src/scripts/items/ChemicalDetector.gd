class_name ChemicalDetector extends Node2D

signal chemical_detector_used

enum ChemicalDetectorState {
	REST,
	DRAGGING,
	LOADING,
	DANGER,
	SAFE
}

@onready var sprite: Sprite2D                  = $Sprite2D
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var timer: Timer                      = $Timer

var resting_texture: Texture2D = preload("res://assets/images/items/chemical-detector/chemical-detector.png")
var hover_texture: Texture2D   = preload("res://assets/images/items/chemical-detector/chemical-detector-hover.png")

var state: ChemicalDetectorState = ChemicalDetectorState.REST
var package: Area2D

func _ready() -> void:
	_update_from_state()

func _on_dragable_drag_start() -> void:
	state = ChemicalDetectorState.DRAGGING
	SoundManager.play_sound(SoundManager.Sound.POWER_ON)
	_update_from_state()

func _on_dragable_drag_end() -> void:
	state = ChemicalDetectorState.REST
	_update_from_state()

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Packages"):
		state = ChemicalDetectorState.LOADING
		package = area
		chemical_detector_used.emit()
		timer.start(3.0)
		_update_from_state()
		
func _on_area_exited(area: Area2D) -> void:
	if area.is_in_group("Packages"):
		if (state == ChemicalDetectorState.LOADING):
			state = ChemicalDetectorState.REST
			_update_from_state()
		timer.stop()

func _on_timer_timeout() -> void:
	if package.get_has_chemical():
		state = ChemicalDetectorState.DANGER
	else:
		state = ChemicalDetectorState.SAFE
	_update_from_state()
	
func _update_from_state() -> void:
	animated_sprite.stop()
	
	match state:
		ChemicalDetectorState.REST:
			sprite.texture = resting_texture
			animated_sprite.animation = "Rest"
		ChemicalDetectorState.DRAGGING:
			sprite.texture = hover_texture
			animated_sprite.animation = "Rest"
		ChemicalDetectorState.LOADING:
			animated_sprite.animation = "Loading"
			SoundManager.play_sound(SoundManager.Sound.LOADING)
		ChemicalDetectorState.SAFE:
			animated_sprite.animation = "Safe"
			SoundManager.play_sound(SoundManager.Sound.CORRECT)
		ChemicalDetectorState.DANGER:
			animated_sprite.animation = "Danger"
			SoundManager.play_sound(SoundManager.Sound.INCORRECT)
			
	animated_sprite.play()
