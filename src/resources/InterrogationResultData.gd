class_name InterrogationResultData extends Resource

enum InterrogationOutcome {
	TRUE_POSITIVE,
	TRUE_NEGATIVE,
	FALSE_POSITIVE,
	FALSE_NEGATIVE,
}

var customer_name: String
var metal_detector_used: bool
var xray_used: bool
var chemical_detector_used: bool 
var approved: bool
var outcome: InterrogationOutcome
