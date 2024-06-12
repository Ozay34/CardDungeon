extends Node

@export var members: Array[Ally] = [Ally.new(), Ally.new(), Ally.new(), Ally.new()]
var turn = 0

func is_full():
	return members.all(func(ally):
		return ally != null
	)

func begin_combat(encounter: Encounter):
	turn = 0
	for member in members:
		member.encounter = encounter
		member.deck.refresh()
	
func end_combat():
	pass

func start_turn():
	for ally in members:
		ally.start_turn(turn)

func end_turn():
	for ally in members:
		ally.end_turn(turn)
	turn += 1
