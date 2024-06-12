extends Resource
class_name Card

class Instance extends Resource:
	
	signal played(action: Card.Action, target: Ally)
	signal canceled
	
	var type: Card
	var primary: Card.Action
	var secondary: Card.Action
	
	func _init(card):
		self.type = card
		self.primary = card.primary.new(self)
		self.secondary = card.secondary.new(self)

class Action extends Effect:
	
	var card: Card.Instance
	
	func _init(card):
		self.card = card

@export var face: Texture
@export var name: String
@export var primary_text: String
@export var secondary_text: String
@export var primary: Script
@export var secondary: Script 

func instantiate():
	return Card.Instance.new(self)
