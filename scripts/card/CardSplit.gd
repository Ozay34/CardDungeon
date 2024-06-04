extends Control
class_name CardSplit

enum Mode{
	PRIMARY,
	SECONDARY
}

@export var card_view: CardView
@export var mode: Mode
@export var card: Card:
	set(v):
		card = v
		
		if not is_node_ready(): await ready
		var text = ""
		match mode:
			Mode.PRIMARY: text = card.primary_text
			Mode.SECONDARY: text = card.secondary_text
		$Layout/CardDescription/Center/Text.text = "[center]%s[/center]" % text

var dragging = false

func _get_drag_data(at_position):
	dragging = true
	var drag_view = self.duplicate()
	drag_view.set_anchors_and_offsets_preset(PRESET_CENTER)
	set_drag_preview(drag_view)
	visible = false
	return self

func _notification(what):
	if what == NOTIFICATION_DRAG_END and dragging:
		if not is_drag_successful():
			visible = true
		dragging = false

func finalize_turn(target):
	var effect = func(): return
	match mode:
		Mode.PRIMARY: effect = card.primary
		Mode.SECONDARY: effect = card.secondary
	card_view.play_finished.emit(target, effect)
	card.played.emit()
	card_view.queue_free()
