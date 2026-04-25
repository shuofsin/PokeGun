extends Node2D
class_name Weapon

@export var weapon_sprite : Sprite2D
@export var bullet_scene : PackedScene # Limit this to just bullet scenes?
@export var time_between_shoot : float
@export var turn_weight : float

var shoot_timer : float
var can_shoot : bool

func _physics_process(delta: float) -> void: 
	rotation = lerp_angle(rotation, (get_global_mouse_position() - global_position).angle(), turn_weight * delta)
	rotation_degrees = wrapf(rotation_degrees, 0, 360)
	
	if weapon_sprite:
		weapon_sprite.flip_v = (rotation_degrees > 90 && rotation_degrees < 270)
	
	if Input.is_action_just_pressed("shoot") and can_shoot: 
		_shoot()
		can_shoot = false
		shoot_timer = time_between_shoot
	
	shoot_timer -= delta
	if shoot_timer <= 0 && !can_shoot: 
		can_shoot = true

func _shoot() -> void: 
	pass
