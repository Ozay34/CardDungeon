extends Control

signal done

func select_hero(i: int):
	for child in $HeroInspect.get_children():
		child.visible = false
	$HeroInspect.get_child(i).visible = true

func done_pressed():
	if Party.is_full():
		done.emit()

func set_hero(rpg_class: RpgClass, i):
	$Party/Heroes.get_child(i).icon = rpg_class.sprite
	
	var hero = Hero.scene.instantiate()
	hero.rpg_class = rpg_class
	Party.heroes[i] = hero
