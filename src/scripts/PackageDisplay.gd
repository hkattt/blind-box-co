extends Node2D 

@onready var image = $Image 

func load_package(package_data: PackageData):
	image.texture = package_data.image
