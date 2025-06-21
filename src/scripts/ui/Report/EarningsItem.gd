class_name EarningsItem extends HBoxContainer

@onready var daily_earnings_label: Label = $DailyEarningsContainer/DailyEarnings
@onready var total_earnings_label: Label = $TotalEarningsContainer/TotalEarnings

const earnings_item_scene: PackedScene = preload("res://scenes/ui/Report/EarningsItem.tscn")

var daily_earnings: int
var total_earnings: int

static func create(p_daily_earnings: int, p_total_earnings: int) -> EarningsItem:
	var earnings_item: EarningsItem = earnings_item_scene.instantiate()
	earnings_item.daily_earnings = p_daily_earnings
	earnings_item.total_earnings = p_total_earnings
	return earnings_item
	
func _ready() -> void:
	daily_earnings_label.text = "$" + str(daily_earnings)
	if (daily_earnings < 0):
		daily_earnings_label.add_theme_color_override("font_color", "#9F76A2")
	total_earnings_label.text = "$" + str(total_earnings)
	if (total_earnings < 0):
		total_earnings_label.add_theme_color_override("font_color", "#9F76A2")
