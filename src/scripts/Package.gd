class_name Package extends Node2D 

@onready var package: Sprite2D      = $Package 
@onready var xray_package: Sprite2D =  $XRayPackage
@onready var mask: Sprite2D         = $Package/Mask

var has_contraband: bool 
var has_metal: bool 
var has_chemical: bool

var xray: Area2D
	
func load_package(package_data: PackageData):
	package.texture = package_data.image
	xray_package.texture = package_data.xray_image
	has_contraband = package_data.has_contraband
	has_metal = package_data.has_metal
	has_chemical = package_data.has_chemical
	
func _process(_delta: float):
	mask.global_position = xray.global_position
	
func set_xray(_xray: Area2D):
	xray = _xray 

func get_has_contraband() -> bool:
	return has_contraband

func get_has_metal() -> bool:
	return has_metal

func get_has_chemical() -> bool:
	return has_chemical
