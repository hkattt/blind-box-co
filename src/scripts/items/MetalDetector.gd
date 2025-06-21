class_name MetalDetector extends Area2D

enum MetalDetectorState {
	ON,
	OFF
}

@onready var sprite: Sprite2D = $Sprite2D

var on_texture: Texture2D        = preload("res://assets/images/items/metal-detector/metal-detector-on.png")
var off_texture: Texture2D       = preload("res://assets/images/items/metal-detector/metal-detector-on.png")
var on_texture_hover: Texture2D  = preload("res://assets/images/items/metal-detector/metal-detector-off-hover.png")
var off_texture_hover: Texture2D = preload("res://assets/images/items/metal-detector/metal-detector-off-hover.png")

func _on_dragable_drag_start() -> void:
	sprite.texture = on_texture_hover

func _on_dragable_drag_end() -> void:
	sprite.texture = on_texture

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Packages"):
		sprite.texture = on_texture_hover

func _on_area_exited(area: Area2D) -> void:
	if area.is_in_group("Packages"):
		sprite.texture = off_texture_hover
