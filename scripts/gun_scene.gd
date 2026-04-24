extends Node2D

@onready var rotation_offset: Node2D = $RotationOffset
@onready var shadow: Sprite2D = $RotationOffset/Sprite2D/Shadow
@onready var shoot_position: Marker2D = $RotationOffset/Sprite2D/ShootPosition
@onready var shoot_timer: Timer = $ShootTimer

var time_between_shoot: float = 0.25
var can_shoot: bool = true

func _ready() -> void:
	shoot_timer.wait_time = time_between_shoot
	shoot_timer.timeout.connect(_on_shoot_timer_timeout)

func _physics_process(delta: float) -> void:
	rotation_offset.rotation = lerp_angle(rotation_offset.rotation, (get_global_mouse_position() - global_position).angle(), 6.5*delta)
	shadow.position = Vector2(-2, 2).rotated(-rotation_offset.rotation)
	
	if Input.is_action_just_pressed("shoot") and can_shoot: 
		_shoot()
		can_shoot = false
		shoot_timer.start()

func _shoot() -> void: 
	pass

func _on_shoot_timer_timeout() -> void: 
	can_shoot = true
