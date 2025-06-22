class_name Document extends Area2D

enum DocumentState {
	UNSIGNED,
	APPROVED,
	DECLINED
}

@onready var sprite: Sprite2D = $Sprite2D

var state: DocumentState = DocumentState.UNSIGNED

var unsigned_texture: Texture2D       = preload("res://assets/images/items/document/document-unsigned.png")
var unsigned_hover_texture: Texture2D = preload("res://assets/images/items/document/document-unsigned-hover.png")
var approve_texture: Texture2D        = preload("res://assets/images/items/document/document-approved.png")
var approve_hover_texture: Texture2D  = preload("res://assets/images/items/document/document-approved-hover.png")
var decline_texture: Texture2D        = preload("res://assets/images/items/document/document-declined.png")
var decline_hover_texture: Texture2D  = preload("res://assets/images/items/document/document-declined-hover.png")

func is_signed() -> bool:
	return state != DocumentState.UNSIGNED

func is_approved() -> bool:
	return state == DocumentState.APPROVED

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Stamps"):
		SoundManager.play_sound(SoundManager.Sound.STAMP)
		if area.type == Stamp.StampType.APPROVE:
			state = DocumentState.APPROVED
			sprite.texture = approve_texture
		else:
			state = DocumentState.DECLINED
			sprite.texture = decline_texture

func _on_dragable_drag_end() -> void:
	match state:
		DocumentState.UNSIGNED:
			sprite.texture = unsigned_texture
		DocumentState.APPROVED:
			sprite.texture = approve_texture
		DocumentState.DECLINED:
			sprite.texture = decline_texture

func _on_dragable_drag_start() -> void:
	match state:
		DocumentState.UNSIGNED:
			sprite.texture = unsigned_hover_texture
		DocumentState.APPROVED:
			sprite.texture = approve_hover_texture
		DocumentState.DECLINED:
			sprite.texture = decline_hover_texture
