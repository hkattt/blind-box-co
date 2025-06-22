class_name DailyReport extends Node2D

signal report_close()

@onready var report: Report = $Report

const daily_report_scene: PackedScene = preload("res://scenes/DailyReport.tscn")

var results: Array[InterrogationResultData]

static func create(p_results: Array[InterrogationResultData]) -> DailyReport:
	var daily_report: DailyReport = daily_report_scene.instantiate()
	daily_report.results = p_results
	return daily_report
	
func _ready() -> void:	
	var report_item_header: ReportItemHeader = ReportItemHeader.create()
	var report_items: Array[ReportItem] = _create_report_items()
	var detector_item_header: DetectorItemHeader = DetectorItemHeader.create()
	var detector_items: Array[DetectorItem] = _create_detector_items()
	var earnings_item: EarningsItem = _create_earnings_item(ReportManager.get_daily_earnings(), ReportManager.get_total_earnings())
	report.load_items(report_item_header, report_items, detector_item_header, detector_items, earnings_item)

func _create_report_items() -> Array[ReportItem]:
	var report_items: Array[ReportItem]     = []
	
	for result in results:		
		var result_earnings: int = ReportManager.outcome_to_earnings(result.outcome)
		ReportManager.add_daily_earnings(result_earnings)
		var report_item: ReportItem = ReportItem.create(
			result.customer_name, 
			ReportManager.outcome_to_string(result.outcome), 
			result_earnings
		)
		report_items.append(report_item)
		
		ReportManager.add_metal_detector_uses(int(result.metal_detector_used))
		ReportManager.add_xray_uses(int(result.xray_used))
		ReportManager.add_chemical_detector_uses(int(result.chemical_detector_used))
	
	return report_items
	
func _create_detector_items() -> Array[DetectorItem]:
	var detector_items: Array[DetectorItem] = []
	
	var metal_detector_item: DetectorItem = DetectorItem.create(
		"Metal detector",
		ReportManager.get_metal_detector_uses(),
		ReportManager.get_metal_detector_cost()
	)
	detector_items.append(metal_detector_item)

	var xray_item: DetectorItem = DetectorItem.create(
		"X-Ray",
		ReportManager.get_xray_uses(),
		ReportManager.get_xray_cost()
	)
	detector_items.append(xray_item)
	
	var chemical_detector_item: DetectorItem = DetectorItem.create(
		"Chemical detector",
		ReportManager.get_chemical_detector_uses(),
		ReportManager.get_chemical_detector_cost()
	)
	detector_items.append(chemical_detector_item)
	
	return detector_items

func _create_earnings_item(p_daily_earnings: int, p_total_earnings: int) -> EarningsItem:
	return EarningsItem.create(p_daily_earnings, p_total_earnings)

func _on_texture_button_pressed() -> void:
	ReportManager.reset()
	report_close.emit()
