extends Node

signal interrogation_complete(result: InterrogationResultData)

@onready var character_slot: Control             = $CharacterSlot
@onready var package_slot: Control               = $PackageSlot
@onready var notice: Notice                      = $Notice
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

func _on_document_received(approved: bool) -> void:
	print('Interrogation: Interrogation complete')
	interrogation_result.approved = approved
	interrogation_result.outcome = ReportManager.interrogation_outcome(approved, package.get_has_contraband())
	interrogation_complete.emit(interrogation_result)

func _on_metal_detector_used() -> void:
	interrogation_result.metal_detector_used = true

func _on_xray_used() -> void:
	interrogation_result.xray_used = true

func _on_chemical_detector_used() -> void:
	interrogation_result.chemical_detector_used = true
