extends StaticBody2D
class_name Prop

@export var hit_box : HitBoxComponent
@export var hit_flash_animation : AnimationPlayer

func _ready() -> void: 
	if hit_box: 
		hit_box.damaged.connect(func(): hit_flash_animation.play("hit"))
