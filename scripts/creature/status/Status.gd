extends IconValue
class_name Status

@export var stack = 0:
	set(v):
		stack = max(v, 0)
		value = stack
		if stack == 0:
			queue_free()

func healed(creature, amt):
	return amt

func damaged(creature, amt):
	return amt

func status_applied(creature, status, amt):
	return amt

func status_removed(creature, status):
	return true

func turn_ended(creature):
	pass

func card_drawn(hero, card):
	return true

#region Instances

class Block extends Status:
	static var icon_texture = preload("res://assets/status/Block.aseprite")
	
	func _init():
		icon = icon_texture

	func damaged(creature, amt):
		return amt - stack
	
	func turn_ended(creature):
		stack = 0

#endregion
