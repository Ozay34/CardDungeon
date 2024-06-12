extends Control

const goblins = preload("res://content/encounters/goblins/Goblins.tres")
const berserker = preload("res://content/classes/berserker/Berserker.tres")

#func _ready():
	#for member in Party.members:
		#member.rpg_class = berserker.instantiate()
	#$PartyFormation.done_pressed()

func party_created():
	$PartyFormation.visible = false
	var combat = Combat.instantiate(goblins)
	add_child(combat)
	combat.begin_combat()

#func begin_combat():2
	#for child in get_children():
		#child.visible = false
	#var combat = Combat.scene.instantiate()
	#add_child(combat)
	#combat.encounter = GoblinEncounter.new()
	#combat.begin()
