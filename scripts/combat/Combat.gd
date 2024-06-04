extends Control
class_name Combat

const scene = preload("Combat.tscn")

signal turn_ended

var turn = 1

var encounter : Encounter:
	set(v):
		encounter = v
		
		if not is_node_ready(): await ready
		for enemy in encounter.enemies:
			$Combatants/Enemies.add_child(enemy)

var creatures:
	get:
		return encounter.enemies + Party.heroes

func begin():
	for hero in Party.heroes:
		hero.refresh()
		$Combatants/Heroes.add_child(hero)
		$Hand.draw_from(hero, 1)
	encounter.determine_intents()

func end_turn():
	turn += 1
	turn_ended.emit()
	
	# Proc Status Effects
	for creature in creatures:
		for status in creature.statuses:
			status.turn_ended(creature)
	
	encounter.enemy_turn()

	for hero in Party.heroes:
		$Hand.draw_from(hero, 1)
