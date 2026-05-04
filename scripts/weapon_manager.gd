extends Node2D

var current_weapon: Weapon
var stowed_weapon: Weapon
var stored_weapons: Array[Weapon]

@onready var label: Label = %Label

func _ready() -> void: 
	Global.weapon_manager = self

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("switch_weapon"):
		_switch_weapon()
	label.text = _get_ammo_display()

func pickup_weapon(new_weapon: Weapon) -> void: 
	if !current_weapon:
		current_weapon = new_weapon
		add_child(current_weapon)
		return
	
	if !stowed_weapon: 
		stowed_weapon = current_weapon
		_set_weapon_enable(stowed_weapon, false)
		current_weapon = new_weapon
		add_child(current_weapon)
		return
	
	var temp_weapon: Weapon = current_weapon
	_set_weapon_enable(temp_weapon, false)
	stored_weapons.append(temp_weapon)
	current_weapon = new_weapon
	add_child(current_weapon)

func _switch_weapon() -> void: 
	if !current_weapon || !stowed_weapon: 
		return 
	
	var temp_weapon: Weapon = current_weapon
	_set_weapon_enable(temp_weapon, false)
	current_weapon = stowed_weapon
	_set_weapon_enable(current_weapon, true)
	stowed_weapon = temp_weapon

func swap_weapon_slots(slot_one: int, slot_two: int) -> void: 
	if !current_weapon || !stowed_weapon:
		return 
	
	if slot_one == 0 && slot_two == 1:
		var temp = current_weapon
		_set_weapon_enable(temp, false)
		current_weapon = stowed_weapon
		_set_weapon_enable(current_weapon, true)
		stowed_weapon = temp
		return 
	
	if slot_one == 0 && slot_two > 1:
		if !stored_weapons[slot_two - 2]: return
		var temp = current_weapon
		_set_weapon_enable(temp, false)
		current_weapon = stored_weapons[slot_two - 2]
		_set_weapon_enable(current_weapon, true)
		stored_weapons[slot_two - 2] = temp
		return 
	
	if slot_one == 1 && slot_two > 1:
		if !stored_weapons[slot_two - 2]: return
		var temp = stowed_weapon
		_set_weapon_enable(temp, false)
		stowed_weapon = stored_weapons[slot_two - 2]
		_set_weapon_enable(stowed_weapon, true)
		stored_weapons[slot_two - 2] = temp
		return

func _get_ammo_display() -> String: 
	if current_weapon: 
		if !current_weapon.is_reloading:
			return str(current_weapon.ammo) + "/" + str(current_weapon.max_ammo)
		else: 
			return str(Global.round_to_digit(current_weapon.reload_timer, 2))
	return ""

func _set_weapon_enable(weapon: Weapon, is_enabled: bool) -> void:
	weapon.set_physics_process(is_enabled)
	weapon.set_process(is_enabled)
	weapon.visible = is_enabled
