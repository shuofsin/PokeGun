extends CharacterBody2D
class_name Player

@onready var animations: AnimatedSprite2D = $Animations
@onready var weapon_manager: Node2D = $WeaponManager

@export var max_speed := 100.0
@export var acceleration_time := 0.1

var current_weapon: Weapon

func _ready() -> void: 
	Global.player = self
	pass

func _physics_process(delta: float) -> void:
	
	# movement
	var input_direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	velocity = velocity.move_toward(input_direction*max_speed, (1.0 / acceleration_time) * delta * max_speed)
	
	if input_direction.y && sign(input_direction.y) != sign(velocity.y):
		velocity.y *= 0.75
	
	if input_direction.x && sign(input_direction.x) != sign(velocity.x):
		velocity.x *= 0.75
	
	# animations
	if input_direction.is_zero_approx():
		animations.play("idle")
	else: 
		animations.play("walk")
	
	if current_weapon && current_weapon.weapon_sprite: 
		animations.flip_h = current_weapon.weapon_sprite.flip_v
	elif velocity.x != 0:
		animations.flip_h = velocity.x < 0
	
	move_and_slide()
