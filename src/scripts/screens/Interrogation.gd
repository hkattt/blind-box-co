extends Node

signal interrogation_complete(result: InterrogationResultData)

@onready var character_slot: Control             = $CharacterSlot
@onready var package_slot: Control               = $PackageSlot
@onready var notice: Notice                      = $Notice
@onready var text_box: TextBox                   = $CanvasLayer/TextBox
@onready var next_button: NextButton             = $CanvasLayer/NextButton
@onready var stamp_approve: Stamp                = $CanvasLayer/StampApprove
@onready var stamp_decline: Stamp                = $CanvasLayer/StampDecline
@onready var document: Document                  = $CanvasLayer/Document
@onready var metal_detector: MetalDetector       = $CanvasLayer/MetalDetector
@onready var xray: XRay                          = $CanvasLayer/XRay
@onready var chemical_detector: ChemicalDetector = $CanvasLayer/ChemicalDetector

var character_scene: PackedScene = preload("res://scenes/Character.tscn")
var package_scene: PackedScene   = preload("res://scenes/Package.tscn")

var character: Character
var package: Package

var interrogation_result: InterrogationResultData
var metal_detector_used: bool
var xray_used: bool
var chemical_detector_used: bool

func _ready() -> void:
	stamp_approve.hide()
	stamp_approve.process_mode = Node.PROCESS_MODE_DISABLED
	stamp_decline.hide()
	stamp_decline.process_mode = Node.PROCESS_MODE_DISABLED
	document.hide()
	document.process_mode = Node.PROCESS_MODE_DISABLED
	metal_detector.hide()
	metal_detector.process_mode = Node.PROCESS_MODE_DISABLED
	xray.hide()
	xray.process_mode = Node.PROCESS_MODE_DISABLED
	chemical_detector.hide()
	chemical_detector.process_mode = Node.PROCESS_MODE_DISABLED

func setup(character_data: CharacterData, package_data: PackageData, notice_data: NoticeData):
	interrogation_result = InterrogationResultData.new()
	interrogation_result.customer_name = character_data.name
	interrogation_result.metal_detector_used = false
	interrogation_result.xray_used = false
	interrogation_result.chemical_detector_used = false
	interrogation_result.approved = false
		
	metal_detector.metal_detector_used.connect(_on_metal_detector_used, CONNECT_ONE_SHOT)
	xray.xray_used.connect(_on_xray_used, CONNECT_ONE_SHOT)
	chemical_detector.chemical_detector_used.connect(_on_chemical_detector_used, CONNECT_ONE_SHOT)
	
	character = character_scene.instantiate()
	character_slot.add_child(character)
	character.load_character(character_data)
	
	character.document_received.connect(_on_document_received, CONNECT_ONE_SHOT)
	
	package = package_scene.instantiate()
	package_slot.add_child(package)
	package.set_xray(xray)
	package.load_package(package_data)
	
	notice.load_notice(notice_data)
	
	DialogueManager.reset()
	DialogueManager.load_dialogues(DialogueManager.DialogueType.CONVERSATION, "test")
	text_box.set_dialogue_sound(character.dialogue_sound)
	_set_text_box()

func _on_document_received(approved: bool) -> void:
	print('Interrogation: Interrogation complete')
	interrogation_result.approved = approved
	interrogation_result.outcome = ReportManager.interrogation_outcome(approved, package.get_has_contraband())
	interrogation_complete.emit(interrogation_result)

func _set_text_box() -> void:
	var line: String = DialogueManager.get_line()
	text_box.set_text(line)

func _on_metal_detector_used() -> void:
	interrogation_result.metal_detector_used = true

func _on_xray_used() -> void:
	interrogation_result.xray_used = true

func _on_chemical_detector_used() -> void:
	interrogation_result.chemical_detector_used = true

func _on_texture_button_pressed() -> void:
	if DialogueManager.is_finished():
		stamp_approve.show()
		stamp_approve.process_mode = Node.PROCESS_MODE_INHERIT
		stamp_decline.show()
		stamp_decline.process_mode = Node.PROCESS_MODE_INHERIT
		document.show()
		document.process_mode = Node.PROCESS_MODE_INHERIT
		metal_detector.show()
		metal_detector.process_mode = Node.PROCESS_MODE_INHERIT
		xray.show()
		xray.process_mode = Node.PROCESS_MODE_INHERIT
		chemical_detector.show()
		chemical_detector.process_mode = Node.PROCESS_MODE_INHERIT
		text_box.hide_text_box()
		text_box.process_mode = Node.PROCESS_MODE_INHERIT
		next_button.hide()
		next_button.process_mode = Node.PROCESS_MODE_INHERIT
	else:
		DialogueManager.next_line()
		_set_text_box()
