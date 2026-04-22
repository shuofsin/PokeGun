extends Area2D

var direction := Vector2(0, 0)
@export var max_speed := 10
var acceleration := 10.0
var velocity := Vector2(0, 0)
var attack_damage := 1

func _ready() -> void: 
	area_entered.connect(_on_area_entered)

func _physics_process(delta: float) -> void: 
	velocity = lerp(velocity, direction.normalized() * max_speed, acceleration * delta)
	global_position += velocity

func _on_area_entered(area: Area2D) -> void: 
	if area.has_method("damage"):
		var attack = Attack.new()
		attack.attack_damage = attack_damage
		area.damage(attack)
		queue_free.call_deferred()
