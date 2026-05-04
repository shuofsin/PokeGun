extends Weapon

func _shoot() -> void: 
	var offset: float = 15
	if weapon_sprite:
		offset = weapon_sprite.texture.get_width() * weapon_sprite.scale.x
	
	var new_bullet = bullet_scene.instantiate()
	new_bullet.global_rotation = global_rotation + randf_range(-0.05, 0.05)
	new_bullet.global_position = Vector2(
		global_position.x + offset * cos(rotation),
		global_position.y + offset * sin(rotation)
	)
	get_tree().current_scene.add_child(new_bullet)
	ammo -= 1
