extends Sprite2D

@onready var shadow: Sprite2D = $Shadow
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var ray_cast_2d: RayCast2D = $RayCast2D
@onready var distance_timer: Timer = $DistanceTimer

var speed : float = 120.0

func _ready() -> void: 
	animation_player.animation_finished.connect(_on_animation_finished)
	distance_timer.timeout.connect(_on_distance_timer_timeout)
	animation_player.play("appear")

func _physics_process(delta: float) -> void:
	global_position += Vector2(1, 0).rotated(rotation) * speed * delta
	shadow.position = Vector2(-2, 2).rotated(-rotation)
	if ray_cast_2d.is_colliding():
		animation_player.play("remove")
	
func _on_animation_finished(animation_name: StringName) -> void: 
	if animation_name == "remove":
		queue_free()

func _on_distance_timer_timeout() -> void: 
	animation_player.play("remove")
