extends Node2D
class_name Projectile

@export var projectile_sprite: Sprite2D
@export var speed: float
@export var time_to_remove: float
@export var hit_box: HitBoxComponent

var remove_timer

func _ready() -> void: 
	if projectile_sprite: 
		projectile_sprite.scale = Vector2(0, 0)
		projectile_sprite.modulate.a = 0
		var appear_tween = create_tween()
		appear_tween.tween_property(projectile_sprite, "scale", Vector2(1, 1), 0.1)
		appear_tween.set_parallel()
		appear_tween.tween_property(projectile_sprite, "modulate:a", 255, 0.1)
	remove_timer = time_to_remove
	hit_box.hit.connect(queue_free)

func _physics_process(delta: float) -> void:
	global_position += Vector2(1, 0).rotated(rotation) * speed * delta
	remove_timer -= delta
	if remove_timer <= 0: 
		if projectile_sprite: 
			var remove_tween = create_tween()
			remove_tween.tween_property(projectile_sprite, "scale", Vector2(0, 0), 0.1)
			remove_tween.set_parallel()
			remove_tween.tween_property(projectile_sprite, "modulate:a", 0, 0.1)
			remove_tween.finished.connect(queue_free)
		else:
			queue_free()
