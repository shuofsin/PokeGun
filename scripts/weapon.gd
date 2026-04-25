extends Node2D
class_name Weapon

@export var weapon_sprite : Sprite2D
@export var bullet_scene : PackedScene # Limit this to just bullet scenes?
@export var time_between_shoot : float
@export var turn_speed : float
@export var full_auto : bool

var shoot_timer : float
var can_shoot : bool

func _physics_process(delta: float) -> void: 
	rotation = lerp_angle(rotation, (get_global_mouse_position() - global_position).angle(), turn_speed * delta)
	rotation_degrees = wrapf(rotation_degrees, 0, 360)
	
	if weapon_sprite:
		weapon_sprite.flip_v = (rotation_degrees > 90 && rotation_degrees < 270)
	
	var firing := Input.is_action_pressed("shoot") if full_auto else Input.is_action_just_pressed("shoot")
	if firing and can_shoot: 
		_shoot()
		can_shoot = false
		shoot_timer = time_between_shoot
	
	shoot_timer -= delta
	if shoot_timer <= 0 && !can_shoot: 
		can_shoot = true

func _shoot() -> void: 
	pass
