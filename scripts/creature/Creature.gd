extends Resource
class_name Creature

signal status_added

func get_effects() -> Array[Effect]:
	var effects: Array[Effect] = []
	effects.append_array(status_effects)
	effects.append_array(temporary_effects)
	return effects

#region Health

var hp: int = 1:
	set(v):
		hp = clamp(v, 0, max_hp)
		
		if hp == 0:
			for effect in get_effects():
				effect.died(self)
		
		changed.emit()

@export var max_hp: int = 1:
	set(v):
		var diff = v - max_hp
		max_hp = v
		if diff > 0:
			hp += diff
		elif max_hp < hp:
			hp = max_hp
		
		changed.emit()

func heal(amt: int):
	for effect in get_effects():
		amt = effect.healed(self, amt)
	hp += amt

func damage(amt: int):
	for effect in get_effects():
		amt = effect.damaged(self, amt)
	hp -= amt

#endregion

#region Statuses

var status_effects: Array[Status.Instance] = []

func get_status(status: Status) -> Status.Instance:
	for status_effect in status_effects:
		if status_effect.status == status:
			return status_effect
	
	var status_effect = status.instantiate()
	status_effect.applied(self)
	status_effect.clear.connect(_delete_status.bind(status_effect))
	status_effects.append(status_effect)
	status_added.emit(status_effect)
	return status_effect

func _delete_status(status):
	status.removed(self)

func apply_status(status: Status, amt: int):
	for effect in get_effects():
		amt = effect.status_applied(self, status, amt)
		
	get_status(status).stack += amt

func remove_status(status: Status):
	for effect in get_effects():
		effect.status_removed(self, status)
		
	get_status(status).stack = 0

#endregion

#region Turns

var temporary_effects: Array[Effect] = []

func add_temporary_effect(effect: Effect):
	effect.applied(self)
	temporary_effects.append(effect)

func start_turn(turn: int):
	for effect in get_effects():
		effect.turn_started(self, turn)

func end_turn(turn: int):
	for effect in temporary_effects:
		effect.removed(self)
	temporary_effects = []
	for effect in get_effects():
		effect.turn_ended(self, turn)

#endregion

#region Encounter

var encounter: Encounter

var facing: Creature:
	get:
		if encounter == null: return null
		var i = Party.members.find(self)
		if i >= 0:
			return encounter.enemies[i]
		i = encounter.enemies.find(self)
		return Party.members[i]
		
var left: Creature:
	get:
		if encounter == null: return null
		var i = Party.members.find(self)
		if i >= 0:
			return Party.members[i-1]
		i = encounter.enemies.find(self)
		return encounter.enemies[i-1]

var right: Creature:
	get:
		if encounter == null: return null
		var i = Party.members.find(self)
		if i >= 0:
			return Party.members[i+1]
		i = encounter.enemies.find(self)
		return encounter.enemies[i+1]

func distance(target: Creature):
	if encounter == null: return null
	var self_i = Party.members.find(self)
	if self_i < 0:
		self_i = encounter.enemies.find(self)
	var target_i = Party.members.find(target)
	if target_i < 0:
		target_i = encounter.enemies.find(target)
	return abs(self_i - target_i)

#endregion
