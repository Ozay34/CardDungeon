extends Resource
class_name Encounter

@export var background: Texture
@export var enemies: Array[Enemy]:
	set(v):
		enemies = v
		for enemy in enemies:
			enemy.encounter = self

var turn = 0

func begin_combat():
	for enemy in enemies:
		enemy.determine_intent()

func end_combat():
	pass

func start_turn():
	for enemy in enemies:
		enemy.start_turn(turn)

func end_turn():
	for enemy in enemies:
		enemy.end_turn(turn)
	turn += 1
