extends Control
class_name PlayableCard

static func instantiate(card: Card.Instance):
	var view = new()
	view.card = card
	view.add_child(CardView.instantiate(card))
	return view

@export var card: Card.Instance
var playing = false
var hovered = false

func _ready() -> void:
	card.canceled.connect(func():
		visible = true
	)
	mouse_entered.connect(func():
		hovered = true
	)
	mouse_exited.connect(func():
		hovered = false
		position.y = 0
	)

func _get_drag_data(at_position: Vector2) -> Variant:
	var pos = Control.new()
	pos.add_child(CardView.instantiate(card))
	set_drag_preview(pos)
	visible = false
	playing = true
	return card

func _notification(what: int) -> void:
	if playing and what == NOTIFICATION_DRAG_END:
		if not is_drag_successful():
			card.canceled.emit()
		playing = false

func _process(delta: float) -> void:
	if hovered:
		var y = get_global_mouse_position().y
		global_position.y = y
		position.y = clamp(position.y, -32, 0)
