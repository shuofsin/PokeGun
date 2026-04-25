extends StaticBody2D
class_name Prop

@export var health_box : HealthBoxComponent
@export var hit_flash_animation : AnimationPlayer

func _ready() -> void: 
	if health_box: 
		health_box.damaged.connect(func(): hit_flash_animation.play("hit"))
