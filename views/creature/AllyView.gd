extends Control
class_name AllyView

const scene = preload("AllyView.tscn")

static func instantiate(ally: Ally):
	var view = scene.instantiate()
	view.ally = ally
	return view

@export var ally: Ally
		
func _ready():
	$Sprite.texture = ally.rpg_class.type.sprite
	ally.changed.connect(update)
	ally.status_added.connect(add_status)
	update()

func update():
	$Health/Current.text = str(ally.hp)
	$Health.value = ally.hp
	$Health/Max.text = str(ally.max_hp)
	$Health.max_value = ally.max_hp
	$DrawPile.value = ally.deck.draw_pile.size()

func add_status(status: Status.Instance):
	$Statuses.add_child(StatusEffectView.new(status))

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	if at_position.x > size.x or at_position.y > size.y:
		return false
	return data is Card.Instance

func _drop_data(at_position: Vector2, card: Variant) -> void:
	ally.hand.cancel_others(card)
	var pos = Control.new()
	pos.add_child(CardSplitView.instantiate(card as Card.Instance, ally))
	pos.position = at_position
	card.canceled.connect(pos.queue_free)
	add_child(pos)
