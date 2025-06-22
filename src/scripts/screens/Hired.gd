class_name Hired extends Node2D

const hired_scene: PackedScene = preload("res://scenes/screens/Hired.tscn")

static func create() -> Hired:
	var hired: Hired = hired_scene.instantiate()
	return hired
