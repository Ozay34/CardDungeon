extends Creature
class_name Hero

const scene = preload("Hero.tscn")

@export var equipment: Equipment
@export var rpg_class: RpgClass:
	set(v):
		rpg_class = v
		if rpg_class != null:
			sprite = rpg_class.sprite
			max_hp = rpg_class.max_hp
		
var draw_pile: Array[Card]
var discard_pile: Array[Card]

func refresh():
	draw_pile = rpg_class.deck.duplicate()
	$Draw.value = draw_pile.size()
	draw_pile.shuffle()
	discard_pile = []

func resuffle():
	draw_pile = discard_pile
	discard_pile = []
	draw_pile.shuffle()

func draw_card():
	if draw_pile.size() == 0:
		if discard_pile.size() == 0:
			return null
		resuffle()
	
	var draw = draw_pile.pop_front()
	
	var status_check = func(instance):
		return instance.card_drawn(self, draw)
	
	if not statuses.all(status_check):
		return null
	$Draw.value = draw_pile.size()
	return draw

func _can_drop_data(at_position, data):
	pass
	
func _drop_data(at_position, data):
	pass
