extends Control

signal done

func _ready():
	for i in Party.members.size():
		var ally = Party.members[i]
		$Inspect.get_child(i).ally = ally
		ally.changed.connect(_update_ally_icon.bind(i, ally))

func _update_ally_icon(i: int, ally: Ally):
	$Party/Allies.get_child(i).icon = ally.rpg_class.type.sprite

func select_ally(i: int):
	for child in $Inspect.get_children():
		child.visible = false
	$Inspect.get_child(i).visible = true

func done_pressed():
	if Party.is_full():
		done.emit()
