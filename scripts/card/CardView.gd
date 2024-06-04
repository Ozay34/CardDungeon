extends Control
class_name CardView

const scene = preload("CardView.tscn")

signal play_started
signal play_canceled
signal play_finished(target, effect)

@export var card: Card:
	set(v):
		card = v
		$Card.card = card
		$Split/Primary.card = card
		$Split/Secondary.card = card
@export var playable = false:
	set(v):
		playable = v
		$Card.playable = playable

var hovered = false

func split():
	$Card.visible = false
	$Split.visible = true

func cancel_play():
	position = Vector2.ZERO
	$Card.visible = true
	$Split.visible = false
	play_canceled.emit()

func _mouse_entered():
	if playable:
		hovered = true

func _mouse_exited():
	position.y = 0
	hovered = false

func _process(delta):
	if hovered:
		global_position.y = get_global_mouse_position().y
		position.y = clamp(position.y, -20, 0)
