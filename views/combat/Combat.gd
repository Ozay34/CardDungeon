extends Control
class_name Combat

const scene = preload("Combat.tscn")

static func instantiate(encounter: Encounter):
	var view = scene.instantiate()
	view.encounter = encounter
	return view

signal turn_ended

@export var encounter: Encounter

func _ready():
	$Background.texture = encounter.background
	for enemy in encounter.enemies:
		$Enemies.add_child(EnemyView.instantiate(enemy))
	for ally in Party.members:
		ally.hand = $HandView.hand
		$Allies.add_child(AllyView.instantiate(ally))

func begin_combat():
	encounter.begin_combat()
	Party.begin_combat(encounter)
	
	while true:
		Party.start_turn()
		await turn_ended
		Party.end_turn()
		encounter.start_turn()
		encounter.end_turn()
	
	encounter.end_combat()
	Party.end_combat()

func end_turn():
	turn_ended.emit()
