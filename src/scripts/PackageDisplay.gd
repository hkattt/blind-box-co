extends Node2D 

@onready var sprite: Sprite2D = $Sprite2D 
@onready var mask: Sprite2D = $Sprite2D/Mask
var xray: Area2D

func set_xray(_xray: Area2D):
	xray = _xray 
	
func load_package(package_data: PackageData):
	sprite.texture = package_data.image
	#mask.global_position = xray.global_position
