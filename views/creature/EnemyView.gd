extends Control
class_name EnemyView

const scene = preload("EnemyView.tscn")

static func instantiate(enemy: Enemy):
	var view = scene.instantiate()
	view.enemy = enemy
	return view

@export var enemy: Enemy
		
func _ready():
	$Sprite.texture = enemy.sprite
	enemy.changed.connect(update)
	enemy.status_added.connect(add_status)
	update()

func update():
	$Health/Current.text = str(enemy.hp)
	$Health.value = enemy.hp
	$Health/Max.text = str(enemy.max_hp)
	$Health.max_value = enemy.max_hp
	$IntentView.intent = enemy.intent

func add_status(status: Status.Instance):
	$Statuses.add_child(StatusEffectView.new(status))

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	if at_position.x > size.x or at_position.y > size.y:
		return false
	return data is Item.Instance

func _drop_data(at_position: Vector2, item: Variant) -> void:
	item.selected.emit(enemy)
