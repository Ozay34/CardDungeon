@tool
extends TextureRect
class_name IconValue

const font = preload("res://assets/ui/HalfBit.tres")
var value_hint = Label.new()

@export var icon : Texture:
	set(v):
		icon = v
		if not is_node_ready(): await ready
		texture = icon
@export var value = 0:
	set(v):
		value = v
		if not is_node_ready(): await ready
		value_hint.text = str(value)

# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(value_hint)
	value_hint.label_settings = font
	value_hint.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
	value_hint.set_anchors_and_offsets_preset(Control.PRESET_BOTTOM_WIDE)
