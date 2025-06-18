extends Node2D 

@onready var sprite = $Sprite2D 

func load_package(package_data: PackageData):
	sprite.texture = package_data.image
