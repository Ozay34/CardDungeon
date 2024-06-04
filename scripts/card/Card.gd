extends Resource
class_name Card

signal played

@export var background: Texture
@export var title := ""
@export var primary_text := ""
@export var secondary_text := ""

func get_view():
	var view = CardView.scene.instantiate()
	view.card = self
	return view

func primary(target):
	pass
	
func secondary(target):
	pass
