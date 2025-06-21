class_name DetectorItemHeader extends HBoxContainer

const detector_item_header_scene: PackedScene = preload("res://scenes/ui/Report/DetectorItemHeader.tscn")

static func create() -> DetectorItemHeader:
	var detector_item_header: DetectorItemHeader = detector_item_header_scene.instantiate()
	return detector_item_header
