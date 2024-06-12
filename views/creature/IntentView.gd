extends IconValue
class_name IntentView

const unknown = preload("res://assets/intent/Unknown.aseprite")

@export var intent: Intent.Instance:
	set(v):
		intent = v
		if intent == null:
			icon = unknown
		else:
			icon = intent.type.icon
			intent.changed.connect(update)
			update()

func update():
	value = intent.amount
