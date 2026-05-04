extends Panel
class_name ItemSlot

@onready var icon: TextureRect = $Icon
var index: int

signal switched(self_index, swap_index)

func _get_drag_data(_at_position: Vector2) -> Variant:
	if icon.texture == null:
		return
	
	var preview = duplicate()
	var centering_node = Control.new()
	centering_node.add_child(preview)
	preview.position -= Vector2(25, 25)
	preview.self_modulate = Color.TRANSPARENT
	centering_node.modulate = Color(centering_node.modulate, 0.5)
	set_drag_preview(centering_node)
	return self

func _can_drop_data(_at_position: Vector2, _data: Variant) -> bool:
	return true

func _drop_data(_at_position: Vector2, data: Variant) -> void: 
	switched.emit(self.index, data.index)
