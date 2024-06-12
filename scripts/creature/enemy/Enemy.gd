extends Creature
class_name Enemy

class AttackPattern extends Resource:
	
	var enemy
	
	func _init(enemy):
		self.enemy = enemy
	
	func determine_intent() -> Intent.Instance:
		return null
	
	func determine_target() -> Creature:
		return null

@export var sprite: Texture
@export var attack_pattern: Script:
	set(v):
		attack_pattern = v
		pattern = attack_pattern.new(self)
var pattern: AttackPattern

var intent: Intent.Instance
var target: Creature

func start_turn(turn: int):
	super.start_turn(turn)
	target.add_temporary_effect(intent)

func end_turn(turn: int):
	super.end_turn(turn)
	determine_intent()

func determine_intent():
	intent = pattern.determine_intent()
	target = pattern.determine_target()
	changed.emit()
