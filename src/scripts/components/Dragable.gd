extends Node2D

signal drag_start
signal drag_end

var dragging: bool = false 
var drag_offset: Vector2 = Vector2.ZERO
# Starting position of the parent object
var resting_position: Vector2

func _ready():
	
	resting_position = get_parent().global_position

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				var mouse_pos = get_global_mouse_position()
				var parent_sprite := get_parent().get_node("Sprite2D")
				# Check if the click is within the parent sprite
				if parent_sprite.get_rect().has_point(get_parent().to_local(mouse_pos)):
					dragging = true
					drag_offset = mouse_pos - get_parent().global_position
					drag_start.emit()
			# Mouse is no longer being pressed
			else:
				if dragging:
					dragging = false
					get_parent().global_position = resting_position
					drag_end.emit()
	elif event is InputEventMouseMotion and dragging:
		if event.relative.length() > 0.1:
			get_parent().global_position = get_global_mouse_position() - drag_offset
