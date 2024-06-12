extends IconValue
class_name StatusEffectView

var status: Status.Instance

func _init(status: Status.Instance):
	self.status = status
	icon = status.type.icon
	value = status.stack
	
	status.changed.connect(update)
	status.clear.connect(queue_free)
	
func update():
	value = status.stack
