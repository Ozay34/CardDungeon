extends Control
class_name PlayableItem

static func instantiate(item: Item.Instance):
	var view = new()
	view.item = item
	view.add_child(ItemView.instantiate(item))
	return view

@export var item: Item.Instance
var playing = false
var hovered = false

func _get_drag_data(at_position: Vector2) -> Variant:
	var pos = Control.new()
	pos.add_child(ItemView.instantiate(item))
	set_drag_preview(pos)
	visible = false
	playing = true
	return item

func _notification(what: int) -> void:
	if playing and what == NOTIFICATION_DRAG_END:
		if not is_drag_successful():
			visible = true
		playing = false
