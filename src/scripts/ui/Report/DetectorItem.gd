class_name DetectorItem extends HBoxContainer

@onready var detector_name_label: Label = $DetectorName
@onready var uses_label: Label          = $NumberOfUses
@onready var total_label: Label         = $TotalCost

const detector_item_scene: PackedScene = preload("res://scenes/ui/Report/DetectorItem.tscn")

var detector_name: String
var number_of_uses: int
var total_cost: int

func _ready() -> void:
	detector_name_label.text = detector_name
	uses_label.text = str(number_of_uses)
	if (total_cost > 0):
		total_label.add_theme_color_override("font_color", "#9F76A2")
	total_label.text = str(total_cost)

static func create(p_detector_name: String, p_number_of_uses: int, p_total_cost: int) -> DetectorItem:
	var detector_item: DetectorItem = detector_item_scene.instantiate()
	detector_item.detector_name = p_detector_name
	detector_item.number_of_uses = p_number_of_uses
	detector_item.total_cost = p_total_cost
	return detector_item
