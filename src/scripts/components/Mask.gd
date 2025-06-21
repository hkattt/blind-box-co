class_name Mask extends Sprite2D

var parent_sprite: Sprite2D
var mask_shader: Shader = preload("res://shaders/Mask.gdshader")

func _ready() -> void:
	parent_sprite = get_parent()
	var shader_material: ShaderMaterial = ShaderMaterial.new() 
	shader_material.shader = mask_shader
	parent_sprite.material = shader_material

func _process(_delta: float) -> void:
	if not parent_sprite is Sprite2D:
		return

	# ensures that the mask itself is not visible
	self_modulate.a = 0.0

	# sets all parameters every frame
	parent_sprite.material.set_shader_parameter('m_mask_texture', texture)
	parent_sprite.material.set_shader_parameter('m_viewport_size', get_viewport().size)
	parent_sprite.material.set_shader_parameter('m_position', position)
	parent_sprite.material.set_shader_parameter('m_rotation', rotation)
	parent_sprite.material.set_shader_parameter('m_scale', scale)
