extends IconValue
class_name Intent

@export var amount = 0:
	set(v):
		amount = v
		value = amount
@export var targets: Array[Creature] = []

func perform():
	pass

#region Instances

class Attack extends Intent:
	
	func _init():
		icon = preload("res://assets/intent/Attack.aseprite")
	
	func perform():
		for target in targets:
			target.damage(amount)

class ApplyStatus extends Intent:
	
	const default_icon = preload("res://assets/intent/Unknown.aseprite")
	
	@export var status := Status:
		set(v):
			status = v
			if "icon_texture" in status:
				icon = status.icon_texture
			else:
				icon = default_icon
	@export var telegraphed = true
	
	func perform():
		for target in targets:
			target.apply_status(status, amount)

#endregion
