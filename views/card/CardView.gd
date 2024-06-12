extends TextureRect
class_name CardView

const scene = preload("CardView.tscn")

static func instantiate(card: Card.Instance):
	var view = scene.instantiate()
	view.card = card
	return view

@export var card: Card.Instance

func _ready():
	texture = card.type.face
	$Layout/Title.text = card.type.name
	$Layout/Primary/Center/Text.text = "[center]" + card.type.primary_text + "[/center]"
	$Layout/Secondary/Center/Text.text = "[center]" + card.type.secondary_text + "[/center]"
