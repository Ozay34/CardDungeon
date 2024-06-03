extends HSplitContainer

signal selected(rpg_class: RpgClass)

@export var classes = [
	Berserker
]

func _ready():
	for rpg_class in classes:
		var button = Button.new()
		button.icon = rpg_class.sprite
		button.pressed.connect(class_selected.bind(rpg_class.new()))
		$Classes.add_child(button)

func class_selected(rpg_class):
	for card in rpg_class.deck:
		$Deck.add_child(card.get_view())
	selected.emit(rpg_class)
