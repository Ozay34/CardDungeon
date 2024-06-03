extends Resource
class_name Encounter

@export var background: Texture
var enemies: Array[Enemy]

func enemy_turn():
	for enemy in enemies:
		enemy.intent.perform()
		enemy.intent = null
	
	determine_intents()

func determine_intents():
	pass

