extends StaticBody2D
class_name Stump

@onready var health_box: HealthBoxComponent = $HealthBoxComponent
@onready var hit_flash_animation: AnimationPlayer = $HitFlashAnimation

func _ready() -> void: 
	# health_box.damaged.connect(func(): hit_flash_animation.play("hit"))
	pass
