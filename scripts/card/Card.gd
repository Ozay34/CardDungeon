extends Resource
class_name Card

@export var background: Texture
@export var title := ""
@export var primary_text := ""
@export var secondary_text := ""

func get_view():
	var view = CardView.scene.instantiate()
	view.card = self
	return view

func get_playable():
	var view = CardView.scene.instantiate()
	view.card = self
	view.playable = true
	return view

func primarty(target):
	pass
	
func secondary(target):
	pass
