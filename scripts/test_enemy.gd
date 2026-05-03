extends Node2D
class_name Enemy

@onready var health_component: HealthComponent = %HealthComponent
@onready var health_box_component: HealthBoxComponent = %HealthBoxComponent
@onready var sprite_2d: Sprite2D = %Sprite2D

var speed: float = 50.0

func _ready() -> void:
	health_box_component.damaged.connect(func():
		if health_component.health <= 0: queue_free()
		)

func _physics_process(delta: float):
	if Global.player: 
		var direction: Vector2 = global_position.direction_to(Global.player.global_position)
		rotation = direction.angle()
		rotation_degrees = wrapf(rotation_degrees, 0, 360)
		sprite_2d.flip_v = (rotation_degrees > 90 && rotation_degrees < 270)
		global_position += Vector2(1, 0).rotated(rotation) * speed * delta
