extends Node2D

@export var max_ammo := 5
var ammo := max_ammo
var fire_rate := 0.2
var fire_timer := 0.0
var reload_speed := 1.0
var reload_timer := 0.0
var is_reloading := false

@onready var sprite: Sprite2D = $Sprite
@onready var bullet_scene: PackedScene = preload("res://scenes/bullet.tscn")
@onready var label: Label = %Label

func _physics_process(delta: float) -> void:
	if ammo >= 0 && !is_reloading: 
		label.text = str(ammo)
	
	if fire_timer >= 0:
		fire_timer -= delta
	
	if reload_timer >= 0:
		reload_timer -= delta
	elif is_reloading:
		is_reloading = false
		ammo = max_ammo
	
	var direction := global_position.direction_to(get_global_mouse_position())
	rotation = direction.angle()
	if direction.x < 0:
		sprite.flip_v = true
	elif direction.x > 0:
		sprite.flip_v = false
	
	if Input.is_action_just_pressed("shoot") && fire_timer <= 0 && ammo > 0 && !is_reloading:
		ammo -= 1 
		fire_timer = fire_rate
		var new_bullet := bullet_scene.instantiate()
		new_bullet.direction = direction
		new_bullet.global_position = global_position
		new_bullet.rotation = rotation
		get_tree().get_current_scene().add_child(new_bullet)
	
	if Input.is_action_just_pressed("reload") && !is_reloading:
		reload_timer = reload_speed
		label.text = "Reloading..."
		is_reloading = true
