extends Area2D

var direction := Vector2(0, 0)
@export var max_speed := 10
var acceleration := 10.0
var velocity := Vector2(0, 0)

func _physics_process(delta: float) -> void: 
	velocity = lerp(velocity, direction.normalized() * max_speed, acceleration * delta)
	global_position += velocity
