extends Node2D
class_name HitscanProjectile

@export var attack: Attack
@onready var ray_cast_2d: RayCast2D = $RayCast2D

var collision_point: Vector2 
var is_bullet_drawn: bool = false

func _ready() -> void: 
	collision_point = to_global(ray_cast_2d.target_position)

func _physics_process(_delta: float) -> void:
	if ray_cast_2d.is_colliding():
		collision_point = ray_cast_2d.get_collision_point()
		if ray_cast_2d.get_collider() is HealthBoxComponent: 
			var health_box_component: HealthBoxComponent = ray_cast_2d.get_collider()
			health_box_component.damage(attack)
			ray_cast_2d.enabled = false
	
	if !is_bullet_drawn: 
		var bullet_line: Line2D = Line2D.new()
		bullet_line.global_position = global_position
		bullet_line.add_point(global_position)
		bullet_line.add_point(collision_point)
		bullet_line.default_color = Color(0.968, 0.806, 0.396, 1.0)
		add_child(bullet_line)
		# var tween_fade: Tween = create_tween()
		# tween_fade.tween_property(self, "modulate:a", 0.0, 0.2)
		# tween_fade.finished.connect(queue_free)
		is_bullet_drawn = true
