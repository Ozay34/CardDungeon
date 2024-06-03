extends Control

var cards : Array[Card]

func draw_from(hero, count=1):
	while count > 0:
		add_card(hero.draw_card())
		count -= 1

func add_card(card):
	$Path.add_child(card.get_playable())
	
	#var card_count = $Path.get_children().size()
	#for child in $Path.get_children():
		#child.progress_ratio = (child.get_index()+1.0) / (card_count+1.0)
