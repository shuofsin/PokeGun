extends Node2D
class_name HitscanProjectile

@export var attack: Attack
@onready var ray_cast_2d: RayCast2D = $RayCast2D

func _ready() -> void: 
	var collision_point: Vector2 = to_global(ray_cast_2d.target_position)
	
	if ray_cast_2d.is_colliding():
		collision_point = ray_cast_2d.get_collision_point()
		if ray_cast_2d.get_collider() is HealthBoxComponent: 
			var health_box_component: HealthBoxComponent = ray_cast_2d.get_collider()
			health_box_component.damage(attack)

	var new_line: Line2D = Line2D.new()
	new_line.add_point(global_position)
	new_line.add_point(collision_point)
	new_line.default_color = Color(0.821, 0.711, 0.0, 1.0)
	new_line.width = 1
	add_child(new_line)
	var distance_tween := create_tween()
	distance_tween.tween_property(self, "modulate:a", 0.0, 0.1)
	distance_tween.finished.connect(queue_free)
