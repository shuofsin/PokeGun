extends Area2D
class_name HitBoxComponent

@export var attack: Attack
signal hit

func _ready() -> void: 
	area_entered.connect(_on_hit_box_entered)

func _on_hit_box_entered(area) -> void: 
	if area is HealthBoxComponent:
		var health_box : HealthBoxComponent = area
		health_box.damage(attack)
	hit.emit.call_deferred()
