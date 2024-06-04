extends Creature
class_name Enemy

const scene = preload("Enemy.tscn")

static func create(sprite, health):
	var enemy = scene.instantiate()
	enemy.sprite = sprite
	enemy.max_hp = health
	return enemy

@export var intent: Intent:
	set(v):
		intent = v
		
		if not is_node_ready(): await ready
		for child in $Intent.get_children():
			$Intent.remove_child(child)
		$Intent.add_child(v)

func _can_drop_data(at_position, data):
	return is_instance_of(data, CardSplit)
	
func _drop_data(at_position, split):
	split.finalize_turn(self)
