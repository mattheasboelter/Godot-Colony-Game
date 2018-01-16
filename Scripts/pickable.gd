extends Area2D

var counter = preload("counter.gd").new()

func _input_event(viewport, event, shape_idx):
	if event.type == InputEvent.MOUSE_BUTTON \
	and event.button_index == BUTTON_RIGHT \
	and event.pressed:
		counter.increment()
		self.get_parent().queue_free()


