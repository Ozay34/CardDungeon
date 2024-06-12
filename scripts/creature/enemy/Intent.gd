extends Resource
class_name Intent

class Instance extends Effect:
	
	var type: Intent
	var amount: int = 0:
		set(v):
			amount = v
			changed.emit()
	
	func _init(intent: Intent):
		self.type = intent

@export var icon: Texture
@export var action: Script

func instantiate():
	return action.new(self)
