extends TextureRect

@export var card: Card:
	set(v):
		card = v
		
		if not is_node_ready(): await ready
		texture = card.background
		$Layout/Title.text = card.title
		$Layout/Primary/Center/Text.text = "[center]%s[/center]" % card.primary_text
		$Layout/Secondary/Center/Text.text = "[center]%s[/center]" % card.secondary_text

@export var playable = false

var dragging = false

func _get_drag_data(at_position):
	if playable:
		dragging = true
		visible = false
		set_drag_preview(card.get_view())
		var parent: CardView = get_parent()
		parent.play_started.emit()
		return parent

func _notification(what):
	if what == NOTIFICATION_DRAG_END and dragging:
		if not is_drag_successful():
			get_parent().play_canceled.emit()
			visible = true
		dragging = false
