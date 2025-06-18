class_name Stamp extends Node2D

enum StampType {
	APPROVE,
	DECLINE
}

@export var type: StampType

@onready var sprite: Sprite2D = $Sprite2D

var approve_texture: Texture2D = preload("res://assets/images/items/stamp-approved.png")
var decline_texture: Texture2D = preload("res://assets/images/items/stamp-declined.png")

func _ready():
	set_sprite()
	
func set_sprite():
	match type:
		StampType.APPROVE:
			sprite.texture = approve_texture
		StampType.DECLINE:
			sprite.texture = decline_texture
