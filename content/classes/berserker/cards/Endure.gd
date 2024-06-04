extends Card
class_name Endure

func _init():
	background = Berserker.card
	title = "Endure"
	primary_text = "Gain Block equal to missing HP"
	secondary_text = "aaaaaaaaaaaaaaaaaa"

func primary(target):
	target.apply_status(Status.Block, 2)
	pass
	
func secondary(target):
	target.apply_status(Status.Block, 10)
	pass
