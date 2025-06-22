class_name ReportItem extends HBoxContainer

@onready var customer_name_label: Label = $CustomerName
@onready var result_label: Label        = $Result
@onready var profit_label: Label        = $Profit

const report_item_scene: PackedScene = preload("res://scenes/ui/Report/ReportItem.tscn")

var customer_name: String
var result: String
var profit: int

func _ready() -> void:
	customer_name_label.text = customer_name
	result_label.text = result
	if (profit < 0):
		profit_label.add_theme_color_override("font_color", "#9F76A2")
	profit_label.text = str(profit)

static func create(p_customer_name: String, p_result: String, p_profit: int) -> ReportItem:
	var report_item: ReportItem = report_item_scene.instantiate()
	report_item.customer_name = p_customer_name
	report_item.result = p_result
	report_item.profit = p_profit
	return report_item
