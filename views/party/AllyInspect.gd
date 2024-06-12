extends HSplitContainer

var rpg_classes = load("res://content/classes/RpgClasses.tres")
@export var items: Array[Item]

var ally: Ally

func _ready():
	for rpg_class in rpg_classes.load_all():
		var button = Button.new()
		button.icon = rpg_class.sprite
		button.pressed.connect(class_selected.bind(rpg_class))
		$Classes.add_child(button)

func class_selected(rpg_class):
	ally.rpg_class = rpg_class.instantiate()
	for card in rpg_class.cards:
		$Deck.add_child(CardView.instantiate(card.instantiate()))
