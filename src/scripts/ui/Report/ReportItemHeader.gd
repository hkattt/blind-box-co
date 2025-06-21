class_name ReportItemHeader extends HBoxContainer

const report_item_header_scene: PackedScene = preload("res://scenes/ui/Report/ReportItemHeader.tscn")

static func create() -> ReportItemHeader:
	var report_item_header: ReportItemHeader = report_item_header_scene.instantiate()
	return report_item_header
