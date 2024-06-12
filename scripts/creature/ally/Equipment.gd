extends Resource
class_name Equipment

const unarmed_primary = preload("res://content/items/UnarmedPrimary.tres")
const unarmed_secondary = preload("res://content/items/UnarmedSecondary.tres")

signal item_added
signal item_removed

@export var head: Item.Instance:
	set(v):
		if head != null: item_removed.emit(head)
		head = v
		if head != null: item_added.emit(head)
@export var body: Item.Instance:
	set(v):
		if body != null: item_removed.emit(body)
		body = v
		if body != null: item_added.emit(body)
@export var hands: Item.Instance:
	set(v):
		if hands != null: item_removed.emit(hands)
		hands = v
		if hands != null: item_added.emit(hands)
@export var feet: Item.Instance:
	set(v):
		if feet != null: item_removed.emit(feet)
		feet = v
		if feet != null: item_added.emit(feet)
@export var trinket: Item.Instance:
	set(v):
		if trinket != null: item_removed.emit(trinket)
		trinket = v
		if trinket != null: item_added.emit(trinket)

@export var primary: Item.Instance = unarmed_primary.instantiate():
	set(v):
		if v == null:
			v = unarmed_primary.instantiate()
		
		if primary != null: item_removed.emit(primary)
		primary = v
		if primary != null: item_added.emit(primary)
@export var secondary: Item.Instance = unarmed_secondary.instantiate():
	set(v):
		if v == null:
			v = unarmed_secondary.instantiate()
			
		if secondary != null: item_removed.emit(secondary)
		secondary = v
		if secondary != null: item_added.emit(secondary)

func get_items() -> Array[Item.Instance]:
	var items: Array[Item.Instance] = []
	if head != null: items.append(head)
	if body != null: items.append(body)
	if hands != null: items.append(hands)
	if feet != null: items.append(feet)
	if feet != null: items.append(trinket)
	if primary != null: items.append(primary)
	if secondary != null: items.append(secondary)
	return items
