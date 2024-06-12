extends Resource
class_name RpgClass

class Instance extends Effect:
	
	var type: RpgClass
	var level = 1
	
	func _init(rpg_class):
		self.type = rpg_class

@export var sprite: Texture
@export var max_hp: int
@export var cards: Array[Card]
@export var passive: Script

func instantiate():
	return passive.new(self)
