extends Node2D

var message_dictionary: Dictionary
@onready var label: Label = $Label

func _ready() -> void: 
	Global.debug = self
	label.text = ""

func _process(_delta: float) -> void:
	for key in message_dictionary:
		label.text += (str(key) + ": " + str(message_dictionary[key]) + "\n")
