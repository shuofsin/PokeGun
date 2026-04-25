extends Area2D
class_name WeaponPickup

@export var weapon_scene: PackedScene
@export var label: Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if label:
		label.visible = false
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _physics_process(_delta: float) -> void: 
	if Input.is_action_just_pressed("interact") && label.visible: 
		if Global.player:
			var weapon = weapon_scene.instantiate()
			Global.player.weapon_manager.pickup_weapon(weapon)
			queue_free.call_deferred()

func _on_body_entered(body) -> void: 
	if body is Player:
		label.visible = true

func _on_body_exited(body) -> void: 
	if body is Player:
		label.visible = false
