extends Resource
class_name Hand

signal card_added

var cards: Array[Card.Instance]

func add_card(card: Card.Instance):
	cards.append(card)
	card_added.emit(card)

func remove_card(card: Card.Instance):
	cards.erase(card)

func cancel_others(skip: Card.Instance):
	for card in cards:
		if card != skip:
			card.canceled.emit()
