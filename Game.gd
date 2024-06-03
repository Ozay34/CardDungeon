extends Control

func _ready():
	$PartyFormation.set_hero(Berserker.new(), 0)
	$PartyFormation.set_hero(Berserker.new(), 1)
	$PartyFormation.set_hero(Berserker.new(), 2)
	$PartyFormation.set_hero(Berserker.new(), 3)
	$PartyFormation.done_pressed()

func begin_combat():
	for child in get_children():
		child.visible = false
	var combat = Combat.scene.instantiate()
	add_child(combat)
	combat.encounter = GoblinEncounter.new()
	combat.begin()
