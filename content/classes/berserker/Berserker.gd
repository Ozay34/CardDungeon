extends RpgClass
class_name Berserker

const sprite = preload("res://assets/classes/Berserker.aseprite")
const card = preload("res://assets/card/Berserker.aseprite")

func _init():
	max_hp = 20
	deck.append(Endure.new())
