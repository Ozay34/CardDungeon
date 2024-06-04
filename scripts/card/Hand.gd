extends Control

var cards:
	get:
		return $Path.get_children().map(func(child):
			return child.get_child(0)
		)

func draw_from(hero, count=1):
	while count > 0:
		var card = hero.draw_card()
		if card == null:
			return
		add_card(card)
		count -= 1

func add_card(card):
	var pf = PathFollow2D.new()
	pf.rotates = false
	var card_view = card.get_view()
	card_view.playable = true
	card_view.play_started.connect(play_started.bind(card_view))
	card_view.play_canceled.connect(play_canceled.bind(card_view))
	card_view.play_finished.connect(play_finished.bind(card_view))
	pf.add_child(card_view)
	$Path.add_child(pf)

func play_started(card_played):
	for card_in_hand in cards:
		if card_in_hand != card_played:
			card_in_hand.cancel_play()
	
func play_canceled(card):
	pass
	
func play_finished(card):
	pass

func _process(delta):
	var card_count = $Path.get_children().size()
	for child in $Path.get_children():
		if child.get_children().size() == 0:
			child.queue_free()
		child.progress_ratio = (child.get_index()+1.0) / (card_count+1.0)
