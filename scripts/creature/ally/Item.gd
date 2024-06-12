extends Resource
class_name Item

enum Slot{
	HEAD,
	BODY,
	HANDS,
	FEET,
	PRIMARY,
	SECONDARY,
	TRINKET
}

class Instance extends Effect:
	
	signal selected(target: Creature)
	signal used(target: Creature)
	
	var type: Item
	
	func _init(item: Item):
		self.type = item

@export var icon: Texture
@export var slot: Slot
@export var name: String
@export var description: String
@export var effect: Script

func instantiate():
	return effect.new(self)
