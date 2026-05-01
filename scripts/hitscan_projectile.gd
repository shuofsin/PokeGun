extends Node2D
class_name HitscanProjectile

@export var attack: Attack
@onready var ray_cast_2d: RayCast2D = $RayCast2D
@onready var line_2d: Line2D = %Line2D

var collision_point: Vector2 
var is_bullet_drawn: bool = false

func _ready() -> void: 
	collision_point = ray_cast_2d.target_position

func _physics_process(_delta: float) -> void:
	# check for collision
	if ray_cast_2d.is_colliding():
		collision_point = to_local(ray_cast_2d.get_collision_point())
		if ray_cast_2d.get_collider() is HealthBoxComponent: 
			var health_box_component: HealthBoxComponent = ray_cast_2d.get_collider()
			health_box_component.damage(attack)
			ray_cast_2d.enabled = false
	
	# draw and fade bullet trail
	line_2d.set_point_position(1, collision_point)
	line_2d.visible = true
	var fade_tween = create_tween()
	fade_tween.tween_property(self, "modulate:a", 0, 0.1)
	fade_tween.finished.connect(queue_free)
