class_name Rejected extends Node2D

const rejected_scene: PackedScene = preload("res://scenes/screens/Rejected.tscn")

static func create() -> Rejected:
	var rejected: Rejected = rejected_scene.instantiate()
	return rejected
