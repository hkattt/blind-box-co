class_name Package extends Node2D 

@onready var package: Sprite2D      = $Package 
@onready var xray_package: Sprite2D =  $XRayPackage
@onready var mask: Sprite2D         = $Package/Mask

var mask_shader: Shader   = preload("res://shaders/Mask.gdshader")
var mask_texture: Texture = preload("res://assets/images/items/x-ray/x-ray-mask-inverted.png")

var has_contraband: bool 
var has_metal: bool 
var has_chemical: bool
var x_offset: int
var y_offset: int

var xray: Area2D

func _ready() -> void:
	var shader_material: ShaderMaterial = ShaderMaterial.new() 
	shader_material.shader = mask_shader
	package.material = shader_material
	
func load_package(package_data: PackageData):
	package.texture = package_data.image
	xray_package.texture = package_data.xray_image
	has_contraband = package_data.has_contraband
	has_metal = package_data.has_metal
	has_chemical = package_data.has_chemical
	x_offset = package_data.x_offset
	y_offset = package_data.y_offset
	
	
func _process(_delta: float):
	mask.global_position = xray.global_position + Vector2(x_offset, y_offset)
	package.material.set_shader_parameter("mask_sampler", mask_texture)
	package.material.set_shader_parameter("mask_offset",  mask.global_position - global_position)
	
func set_xray(_xray: Area2D):
	xray = _xray 

func get_has_contraband() -> bool:
	return has_contraband

func get_has_metal() -> bool:
	return has_metal

func get_has_chemical() -> bool:
	return has_chemical
