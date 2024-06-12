extends Creature
class_name Ally

func get_effects():
	return [rpg_class] + equipment.get_items() + super.get_effects()


func _init():
	equipment.item_added.connect(_notify_item_added)
	equipment.item_removed.connect(_notify_item_removed)
	for item in equipment.get_items():
		item.used.connect(_notify_item_used.bind(item))
	
	deck.changed.connect(_notify_changed)
	deck.reshuffled.connect(_notify_reshuffled)
	deck.card_drawn.connect(_notify_card_drawn)
	deck.card_discarded.connect(_notify_card_discarded)

#region RPG Class

@export var rpg_class: RpgClass.Instance:
	set(v):
		rpg_class = v
		max_hp = rpg_class.type.max_hp
		deck.load_cards(rpg_class.type.cards)
		changed.emit()

#endregion

#region Equipment

var equipment := Equipment.new()

func _notify_item_added(item):
	item.used.connect(_notify_item_used.bind(item))
	item.applied(self)

func _notify_item_removed(item):
	item.used.disconnect(_notify_item_used)
	item.removed(self)

func _notify_item_used(target: Creature, item: Item.Instance):
	for effect in get_effects():
		effect.item_used(self, item, target)
	
	target.add_temporary_effect(item)

#endregion

#region Cards

var deck := Deck.new()
var hand: Hand

func _notify_changed():
	changed.emit()

func _notify_reshuffled(card):
	for effect in get_effects():
		effect.deck_shuffled(self)

func _notify_card_drawn(card):
	for effect in get_effects():
		effect.card_drawn(self, card)
	card.played.connect(_notify_card_action_played)
	hand.add_card(card)

func _notify_card_discarded(card):
	for effect in get_effects():
		effect.card_discarded(self, card)
	hand.remove_card(card)

func _notify_card_action_played(card_action: Card.Action, target: Ally):
	card_action.card.played.disconnect(_notify_card_action_played)
	for effect in get_effects():
		effect.card_action_played(self, card_action, target)
	
	target.add_temporary_effect(card_action)

func start_turn(turn: int):
	super.start_turn(turn)
	deck.draw()

#endregion
