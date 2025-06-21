class_name ChemicalDetector extends Node2D

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
	animated_sprite.play()
	update_textures()

func _on_dragable_drag_start() -> void:
	state = ChemicalDetectorState.DRAGGING
	update_textures()

func _on_dragable_drag_end() -> void:
	state = ChemicalDetectorState.REST
	update_textures()

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Packages"):
		state = ChemicalDetectorState.LOADING
		package = area
		timer.start(3.0)
		update_textures()
		
func _on_area_exited(area: Area2D) -> void:
	if area.is_in_group("Packages"):
		if (state == ChemicalDetectorState.LOADING):
			state = ChemicalDetectorState.REST
		timer.stop()
		update_textures()

func _on_timer_timeout() -> void:
	if package.get_has_chemical():
		state = ChemicalDetectorState.DANGER
	else:
		state = ChemicalDetectorState.SAFE
	update_textures()
	
func update_textures() -> void:
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
		ChemicalDetectorState.SAFE:
			animated_sprite.animation = "Safe"
		ChemicalDetectorState.DANGER:
			animated_sprite.animation = "Danger"
			
	animated_sprite.play()
