extends Node2D

var message_dictionary: Dictionary[String, String]
@onready var label: Label = $Label

func _ready() -> void: 
	Global.debug = self
	message_dictionary = {}
	label.text = ""

func _process(_delta: float) -> void:
	label.text = ""
	for key in message_dictionary:
		label.text += (key + ": " + message_dictionary[key] + "\n")

func add_message(key: String, message: String) -> void: 
	message_dictionary[key] = message
