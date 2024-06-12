extends Control
class_name ItemView

const scene = preload("ItemView.tscn")

static func instantiate(item: Item.Instance):
	var view = scene.instantiate()
	view.item = item
	return view

@export var item: Item.Instance:
	set(v):
		item = v
		
		if not is_node_ready(): await ready
		$Title/Icon.texture = item.type.icon
		$Title/Text.text = item.type.name
		$Description/Center/Text.text = item.type.description
