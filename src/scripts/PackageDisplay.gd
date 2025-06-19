extends Node2D 

@onready var sprite: Sprite2D = $Sprite2D 
@onready var mask: Sprite2D = $Mask 

var shader: Shader = preload("res://shaders/Package.gdshader")
var xray: Area2D

func set_xray(_xray: Area2D):
	xray = _xray 
	
func load_package(package_data: PackageData):
	sprite.texture = package_data.image
	var shader_material: ShaderMaterial = ShaderMaterial.new() 
	shader_material.shader = shader
	sprite.material = shader_material

func _process(_delta: float) -> void:
	sprite.material.set_shader_parameter("mask_texture", mask.texture)
	sprite.material.set_shader_parameter("mask_position", mask.global_position / Vector2(get_viewport().size))
	sprite.material.set_shader_parameter("mask_size", mask.texture.get_size() / Vector2(get_viewport().size))
