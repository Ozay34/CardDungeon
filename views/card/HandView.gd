extends Control

@export var hand := Hand.new()

func _ready() -> void:
	hand.card_added.connect(add_card)
	
func add_card(card: Card.Instance):
	var view = PlayableCard.instantiate(card)
	var point = PathFollow2D.new()
	point.rotates = false
	point.add_child(view)
	card.played.connect(_notify_card_played.bind(point))
	$Path.add_child(point)

func _notify_card_played(card_action: Card.Action, target: Creature, point: PathFollow2D):
	point.queue_free()

func _process(delta: float) -> void:
	var i = 0
	var count = $Path.get_child_count()
	for child in $Path.get_children():
		child.progress_ratio = (i+1.0) / (count+1.0)
		i += 1
