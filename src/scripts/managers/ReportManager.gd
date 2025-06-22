extends Node

const METAL_DETECTOR_COST: int    = 10
const XRAY_COST: int              = 20
const CHEMICAL_DETECTOR_COST: int = 10

var daily_earnings: int = 0
var total_earnings: int = 0

var metal_detector_uses: int = 0
var xray_uses: int = 0
var chemical_detector_uses: int = 0

func reset_total() -> void:
	total_earnings = 0

func reset():
	daily_earnings = 0
	metal_detector_uses = 0
	xray_uses = 0
	chemical_detector_uses = 0

func get_daily_earnings() -> int:
	return daily_earnings

func get_total_earnings() -> int:
	return total_earnings

func get_metal_detector_uses() -> int:
	return metal_detector_uses
	
func get_xray_uses() -> int:
	return xray_uses

func get_chemical_detector_uses() -> int:
	return chemical_detector_uses

func get_metal_detector_cost():
	return metal_detector_uses * METAL_DETECTOR_COST

func get_xray_cost():
	return xray_uses * XRAY_COST

func get_chemical_detector_cost():
	return chemical_detector_uses * CHEMICAL_DETECTOR_COST

func add_metal_detector_uses(count: int):
	metal_detector_uses += count
	var cost: int = count * METAL_DETECTOR_COST
	daily_earnings -= cost
	total_earnings -= cost
	
func add_xray_uses(count: int):
	xray_uses += count
	var cost: int = count * XRAY_COST
	daily_earnings -= cost
	total_earnings -= cost
	
func add_chemical_detector_uses(count: int):
	chemical_detector_uses += count
	var cost: int = count * CHEMICAL_DETECTOR_COST
	daily_earnings -= cost
	total_earnings -= cost
	
func add_daily_earnings(earnings: int):
	daily_earnings += earnings
	total_earnings += earnings

func interrogation_outcome(approved: bool, has_contraband: bool) -> InterrogationResultData.InterrogationOutcome:
	if approved:
		if has_contraband:
			return InterrogationResultData.InterrogationOutcome.FALSE_NEGATIVE
		else:
			return InterrogationResultData.InterrogationOutcome.TRUE_NEGATIVE
	else:
		if has_contraband:
			return InterrogationResultData.InterrogationOutcome.TRUE_POSITIVE
		else:
			return InterrogationResultData.InterrogationOutcome.FALSE_POSITIVE

func outcome_to_string(outcome: InterrogationResultData.InterrogationOutcome) -> String:
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
			
func outcome_to_earnings(outcome: InterrogationResultData.InterrogationOutcome) -> int:
	match outcome:
		InterrogationResultData.InterrogationOutcome.TRUE_POSITIVE:
			return 50
		InterrogationResultData.InterrogationOutcome.TRUE_NEGATIVE:
			return 40
		InterrogationResultData.InterrogationOutcome.FALSE_POSITIVE:
			return -10
		InterrogationResultData.InterrogationOutcome.FALSE_NEGATIVE:
			return -100
		_:
			return 0
