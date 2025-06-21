class_name Notice extends Node2D

@onready var label: Label = $Label

var pending_notice_data: NoticeData

func _ready():
	if pending_notice_data:
		_process_notice_data()
		
func _process_notice_data():
	label.text = pending_notice_data.text
	
func load_notice(notice_data: NoticeData):
	pending_notice_data = notice_data
	if is_inside_tree():
		_process_notice_data()
