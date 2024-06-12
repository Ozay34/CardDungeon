extends Resource
class_name Effect

func applied(creature: Creature):
	pass
	
func removed(creature: Creature):
	pass

func turn_started(creature: Creature, turn: int):
	pass

func turn_ended(creature: Creature, turn: int):
	pass

func healed(creature: Creature, amt: int) -> int:
	return amt

func damaged(creature: Creature, amt: int) -> int:
	return amt

func died(creature: Creature):
	pass

func status_applied(creature: Creature, status: Status, amt: int) -> int:
	return amt

func status_removed(creature: Creature, status: Status):
	pass

func card_drawn(ally: Ally, card: Card.Instance):
	pass
	
func card_discarded(ally: Ally, card: Card.Instance):
	pass

func deck_shuffled(ally: Ally):
	pass

func card_action_played(ally: Ally, action: Card.Action, target: Ally):
	pass

func item_used(ally: Ally, item: Item.Instance, target: Creature):
	pass
