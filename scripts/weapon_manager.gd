extends Node2D

var current_weapon: Weapon
var current_weapon_slot: int = -1
var weapons: Array[Weapon]

func _ready() -> void: 
	Global.weapon_manager = self
	var weapon_scene := preload("res://scenes/basic_shotgun.tscn")
	var new_weapon: Weapon = weapon_scene.instantiate()
	pickup_weapon(new_weapon)

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("switch_weapon"):
		var next_slot = current_weapon_slot + 1
		if next_slot >= weapons.size(): 
			next_slot = 0
		equip_weapon(next_slot)
	Global.debug.add_message("Ammo", get_ammo_display())

func pickup_weapon(new_weapon: Weapon) -> void: 
	for weapon in weapons: 
		weapon.set_physics_process(false)
		weapon.set_process(false)
		weapon.visible = false
	weapons.append(new_weapon)
	add_child(new_weapon)
	current_weapon_slot += 1
	current_weapon = weapons[current_weapon_slot]

func equip_weapon(weapon_slot: int) -> void: 
	if weapon_slot >= weapons.size() || weapons.size() == 0:
		return
	for weapon in weapons:
		weapon.set_physics_process(false)
		weapon.set_process(false)
		weapon.visible = false
	current_weapon = weapons[weapon_slot]
	current_weapon.set_physics_process(true)
	current_weapon.set_process(true)
	current_weapon.visible = true
	current_weapon_slot = weapon_slot

func get_ammo_display() -> String: 
	if current_weapon: 
		if !current_weapon.is_reloading:
			return str(current_weapon.ammo) + "/" + str(current_weapon.max_ammo)
		else: 
			return str(int(current_weapon.reload_timer))
	return ""
