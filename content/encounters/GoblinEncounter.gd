extends Encounter
class_name GoblinEncounter

const icon = preload("res://assets/enemy/Goblin.aseprite")

class Goblin:
	var instance = Enemy.create(icon, randi_range(10, 18))
	var attacking = false
	
	func set_intent():
		var intent
		if attacking:
			intent = Intent.Attack.new()
			intent.amount = randi_range(4, 6)
		else:
			intent = Intent.ApplyStatus.new()
			intent.status = Status.Block
			intent.amount = randi_range(2, 3)
			intent.targets.append(instance)
		instance.intent = intent
		attacking = !attacking

var goblin1 = Goblin.new()
var goblin2 = Goblin.new()
var goblin3 = Goblin.new()
var goblin4 = Goblin.new()

func _init():
	enemies.append(goblin1.instance)
	enemies.append(goblin2.instance)
	goblin2.attacking = true
	enemies.append(goblin3.instance)
	enemies.append(goblin4.instance)
	goblin4.attacking = true

func determine_intents():
	goblin1.set_intent()
	goblin2.set_intent()
	goblin3.set_intent()
	goblin4.set_intent()
