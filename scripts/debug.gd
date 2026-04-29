extends Node2D

var message_dictionary: Dictionary[String, String]
@onready var label: Label = $Label
@onready var sprite_2d: Sprite2D = $Sprite2D

func _ready() -> void: 
	Global.debug = self
	message_dictionary = {}
	label.text = ""

func _process(_delta: float) -> void:
	label.text = ""
	for key in message_dictionary:
		label.text += (key + ": " + message_dictionary[key] + "\n")
	
	if Global.weapon_manager.current_weapon && Global.weapon_manager.current_weapon.weapon_sprite:
		sprite_2d.set_texture(Global.weapon_manager.current_weapon.weapon_sprite.get_texture())

func add_message(key: String, message: String) -> void: 
	message_dictionary[key] = message
