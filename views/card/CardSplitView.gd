extends Control
class_name CardSplitView

const scene = preload("CardSplitView.tscn")

static func instantiate(card: Card.Instance, ally: Ally):
	var view = scene.instantiate()
	view.card = card
	view.ally = ally
	return view

@export var card: Card.Instance
@export var ally: Ally

func _ready():
	$Split/Primary/CardAction/Center/Text.text = "[center]" + card.type.primary_text + "[/center]"
	$Split/Primary/Item.add_child(PlayableItem.instantiate(ally.equipment.primary))
	ally.equipment.primary.selected.connect(item_played.bind(ally.equipment.primary, card.primary))
	$Split/Secondary/CardAction/Center/Text.text = "[center]" + card.type.secondary_text + "[/center]"
	$Split/Secondary/Item.add_child(PlayableItem.instantiate(ally.equipment.secondary))
	ally.equipment.secondary.selected.connect(item_played.bind(ally.equipment.secondary, card.secondary))

func item_played(target: Creature, item: Item.Instance, action: Card.Action):
	card.played.emit(action, ally)
	item.used.emit(target)
	queue_free()

func cancel():
	card.canceled.emit()
