@tool
extends Control
class_name CardView

const scene = preload("CardView.tscn")

@export var card: Card:
	set(v):
		card = v
		
		if not is_node_ready(): await ready
		$Background.texture = card.background
		$Background/Layout/Title.text = card.title
		$Background/Layout/Primary/Center/Text.text = "[center]%s[/center]" % card.primary_text
		$Background/Layout/Secondary/Center/Text.text = "[center]%s[/center]" % card.secondary_text
@export var playable = false

var hovered = false

func _get_drag_data(at_position):
	print("test")
	if playable:
		return card

#func mouse_entered():
	#if playable:
		#hovered = true
	#
#func mouse_exited():
	#position.y = 0
	#hovered = false
#
#func _process(delta):
	#if hovered:
		#global_position.y = get_global_mouse_position().y
