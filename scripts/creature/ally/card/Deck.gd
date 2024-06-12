extends Resource
class_name Deck

signal reshuffled
signal card_drawn
signal card_discarded

@export var cards: Array[Card.Instance]
var draw_pile: Array[Card.Instance]
var discard_pile: Array[Card.Instance]

func load_cards(load: Array[Card]):
	cards = []
	for card in load:
		cards.append(card.instantiate())

func refresh():
	draw_pile = cards.duplicate()
	draw_pile.shuffle()
	discard_pile = []
	changed.emit()

func reshuffle():
	draw_pile = discard_pile
	draw_pile.shuffle()
	discard_pile = []
	reshuffled.emit()
	changed.emit()

func draw() -> Card.Instance:
	if draw_pile.size() == 0:
		if discard_pile.size() == 0:
			return null
		reshuffle()
	
	var card = draw_pile.pop_back()
	card.played.connect(_notify_card_played)
	card_drawn.emit(card)
	changed.emit()
	return card

func peek() -> Card.Instance:
	return draw_pile.back()

func _notify_card_played(card_action: Card.Action, target: Creature):
	card_action.card.played.disconnect(_notify_card_played)
	discard_pile.append(card_action.card)
	card_discarded.emit(card_action.card)
	changed.emit()
