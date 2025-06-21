class_name Report extends Control

@onready var items: VBoxContainer = $TextureRect/MarginContainer/ScrollContainer/ReportItems

func load_items(
	report_item_header: ReportItemHeader, 
	report_items: Array[ReportItem], 
	detector_item_header: DetectorItemHeader, 
	detector_items: Array[DetectorItem],
	earnings_item: EarningsItem):
	items.add_child(report_item_header)
	for report_item in report_items:
		items.add_child(report_item)
		
	items.add_child(detector_item_header)
	for detector_item in detector_items:
		items.add_child(detector_item)
		
	items.add_child(earnings_item)
