class_name DailyReport extends Node2D

signal report_close(net_money: int)

@onready var report: Report = $Report

const daily_report_scene: PackedScene = preload("res://scenes/DailyReport.tscn")

var results: Array[InterrogationResultData]

var daily_earnings: int = 0
var total_earnings: int 

var metal_detector_uses: int = 0
var xray_uses: int = 0
var chemical_detector_uses: int = 0

var metal_detector_cost: int    = 50
var xray_cost: int              = 100
var chemical_detector_cost: int = 75

static func create(p_results: Array[InterrogationResultData], p_total_earnings) -> DailyReport:
	var daily_report: DailyReport = daily_report_scene.instantiate()
	daily_report.results = p_results
	daily_report.total_earnings = p_total_earnings
	return daily_report
	
func _ready() -> void:	
	var report_item_header: ReportItemHeader = ReportItemHeader.create()
	var report_items: Array[ReportItem] = _create_report_items()
	var detector_item_header: DetectorItemHeader = DetectorItemHeader.create()
	var detector_items: Array[DetectorItem] = _create_detector_items()
	total_earnings += daily_earnings
	var earnings_item: EarningsItem = _create_earnings_item(daily_earnings, total_earnings)
	report.load_items(report_item_header, report_items, detector_item_header, detector_items, earnings_item)

func _create_report_items() -> Array[ReportItem]:
	var report_items: Array[ReportItem]     = []
	
	for result in results:		
		var earnings: int = _outcome_to_pay(result.outcome)
		daily_earnings += earnings
		var report_item: ReportItem = ReportItem.create(
			result.customer_name, 
			_outcome_to_string(result.outcome), 
			earnings
		)
		report_items.append(report_item)
		
		metal_detector_uses += int(result.metal_detector_used)
		xray_uses += int(result.xray_used)
		chemical_detector_uses += int(result.chemical_detector_used)
	
	return report_items
	
func _create_detector_items() -> Array[DetectorItem]:
	var detector_items: Array[DetectorItem] = []
	
	var cost: int = metal_detector_cost * metal_detector_uses
	daily_earnings -= cost
	var metal_detector_item: DetectorItem = DetectorItem.create(
		"Metal detector",
		metal_detector_uses,
		cost
	)
	detector_items.append(metal_detector_item)
	
	cost = xray_cost * xray_uses
	daily_earnings -= cost
	var xray_item: DetectorItem = DetectorItem.create(
		"X-Ray",
		xray_uses,
		xray_cost * xray_uses
	)
	detector_items.append(xray_item)
	
	cost = chemical_detector_cost * chemical_detector_uses
	daily_earnings -= cost
	var chemical_detector_item: DetectorItem = DetectorItem.create(
		"Chemical detector",
		chemical_detector_uses,
		chemical_detector_cost * chemical_detector_uses
	)
	detector_items.append(chemical_detector_item)
	
	return detector_items

func _create_earnings_item(p_daily_earnings: int, p_total_earnings: int) -> EarningsItem:
	return EarningsItem.create(p_daily_earnings, p_total_earnings)

func _outcome_to_string(outcome: InterrogationResultData.InterrogationOutcome) -> String:
	match outcome:
		InterrogationResultData.InterrogationOutcome.TRUE_POSITIVE:
			return "Denied contraband"
		InterrogationResultData.InterrogationOutcome.TRUE_NEGATIVE:
			return "Approved legal"
		InterrogationResultData.InterrogationOutcome.FALSE_POSITIVE:
			return "Denied legal"
		InterrogationResultData.InterrogationOutcome.FALSE_NEGATIVE:
			return "Approved contraband"
		_:
			return "Invalid"
			
func _outcome_to_pay(outcome: InterrogationResultData.InterrogationOutcome) -> int:
	match outcome:
		InterrogationResultData.InterrogationOutcome.TRUE_POSITIVE:
			return 100
		InterrogationResultData.InterrogationOutcome.TRUE_NEGATIVE:
			return 100
		InterrogationResultData.InterrogationOutcome.FALSE_POSITIVE:
			return -10
		InterrogationResultData.InterrogationOutcome.FALSE_NEGATIVE:
			return -100
		_:
			return 0

func _on_texture_button_pressed() -> void:
	report_close.emit(total_earnings)
