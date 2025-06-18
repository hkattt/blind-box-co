class_name Stamp extends Node2D

enum StampType {
	APPROVE,
	DECLINE
}

@export var type: StampType

@onready var sprite: Sprite2D = $Sprite2D

var approve_texture: Texture2D = preload("res://assets/images/items/stamp/stamp-approved.png")
var decline_texture: Texture2D = preload("res://assets/images/items/stamp/stamp-declined.png")
var approve_texture_hover: Texture2D = preload("res://assets/images/items/stamp/stamp-approved-hover.png")
var decline_texture_hover: Texture2D = preload("res://assets/images/items/stamp/stamp-declined-hover.png")

func _ready():
	set_resting_texture()
	
func set_resting_texture():
	match type:
		StampType.APPROVE:
			sprite.texture = approve_texture
		StampType.DECLINE:
			sprite.texture = decline_texture
			
func set_hover_texture():
	match type:
		StampType.APPROVE:
			sprite.texture = approve_texture_hover
		StampType.DECLINE:
			sprite.texture = decline_texture_hover
			
func _on_mouse_entered() -> void:
	set_hover_texture()

func _on_mouse_exited() -> void:
	set_resting_texture()
