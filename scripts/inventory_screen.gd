extends CanvasLayer

@onready var grid_container: GridContainer = %GridContainer
var item_slots: Array[ItemSlot]

func _ready() -> void: 
	visible = false
	layer = -2
	for child in grid_container.get_children():
		item_slots.append(child)
	
	for i in range(item_slots.size()):
		item_slots[i].index = i
		item_slots[i].switched.connect(_switch_weapon_inventory)

func _physics_process(_delta: float) -> void:
	if !Global.weapon_manager:
		return
	
	if Global.weapon_manager.current_weapon:
		item_slots[0].icon.texture = Global.weapon_manager.current_weapon.weapon_sprite.texture
	
	if Global.weapon_manager.stowed_weapon:
		item_slots[1].icon.texture = Global.weapon_manager.stowed_weapon.weapon_sprite.texture
	
	if !Global.weapon_manager.stored_weapons.is_empty():
		for i in range(Global.weapon_manager.stored_weapons.size()):
			item_slots[i + 2].icon.texture = Global.weapon_manager.stored_weapons[i].weapon_sprite.texture
	
	if Input.is_action_just_pressed("toggle_inventory"):
		visible = !visible
		layer *= -1

func _switch_weapon_inventory(index_one: int, index_two: int) -> void: 
	if Global.weapon_manager:
		Global.weapon_manager.swap_weapon_slots(index_one, index_two)
