extends Resource
class_name Status

class Instance extends Effect:
	
	signal clear
	
	var type: Status
	var stack: int = 0:
		set(v):
			stack = v
			
			changed.emit()
			if stack == 0:
				clear.emit()
	
	func _init(status):
		self.type = status

@export var icon: Texture
@export var effect: Script

func instantiate():
	return effect.new(self)
