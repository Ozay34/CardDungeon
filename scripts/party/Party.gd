extends Node

@export var heroes: Array[Hero] = [null, null, null, null]

func is_full():
	return heroes.all(func(hero):
		return hero != null
	)
