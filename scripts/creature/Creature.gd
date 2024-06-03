extends Control
class_name Creature

@export var sprite: Texture:
	set(v):
		sprite = v
		
		if not is_node_ready(): await ready
		$Sprite.texture = sprite

#region Health

@export var hp = 1:
	set(v):
		hp = min(v, max_hp)
		
		if not is_node_ready(): await ready
		$Health.value = hp
		$Health/Current.text = str(hp)
		
@export var max_hp = 1:
	set(v):
		var diff = v - max_hp
		max_hp = v
		if diff > 0:
			hp += diff
		elif max_hp < hp:
			hp = max_hp
		
		if not is_node_ready(): await ready
		$Health.max_value = max_hp
		$Health/Max.text = str(max_hp)

func heal(amt):
	for status in $Statuses.get_children():
		amt = status.healed(self, amt)
	hp += amt

func damage(amt):
	for status in $Statuses.get_children():
		amt = status.damaged(self, amt)
	hp -= amt

#endregion

#region Statuses

var statuses:
	get:
		return $Statuses.get_children()

func get_status(type):
	var status = statuses.filter(func(child):
		return is_instance_of(child, type)
	)
	if status.size() > 0:
		return status[0]
		
	var instance = type.new()
	$Statuses.add_child(instance)
	return instance

func apply_status(status, amt):
	for existing_status in statuses:
		amt = existing_status.status_applied(self, status, amt)
	get_status(status).stack += amt

func remove_status(status):
	var status_check = func(instance):
		return instance.status_removed(self, status)
	
	if statuses.all(status_check):
		get_status(status).stack = 0

#endregion
