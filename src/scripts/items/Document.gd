class_name Document extends Area2D

enum DocumentState {
	UNSIGNED,
	APPROVED,
	DECLINED
}

@onready var sprite: Sprite2D = $Sprite2D

var state: DocumentState = DocumentState.UNSIGNED

var approve_texture: Texture2D = preload("res://assets/images/items/document/document-approved.png")
var decline_texture: Texture2D = preload("res://assets/images/items/document/document-declined.png")

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Stamps"):
		if area.type == Stamp.StampType.APPROVE:
			state = DocumentState.APPROVED
			sprite.texture = approve_texture
		else:
			state = DocumentState.DECLINED
			sprite.texture = decline_texture
