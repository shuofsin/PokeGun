extends Area2D

@onready var label: Label = $Label
@onready var weapon_scene: PackedScene = preload("res://scenes/basic_pistol.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label.visible = false
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _physics_process(_delta: float) -> void: 
	if Input.is_action_just_pressed("interact") && label.visible: 
		if Global.player:
			var weapon = weapon_scene.instantiate()
			Global.player.weapon_manager.add_child(weapon)
			Global.player.current_weapon = weapon

func _on_body_entered(body) -> void: 
	if body is Player:
		label.visible = true

func _on_body_exited(body) -> void: 
	if body is Player:
		label.visible = false
