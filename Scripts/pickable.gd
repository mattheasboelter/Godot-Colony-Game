extends Area2D

signal item_collected

var counter = preload("counter.gd").new()

func _ready():
	var player = get_node("/root/Root/Player/Inventory")
	self.connect("item_collected", player, "_on_item_collected")

func _input_event(viewport, event, shape_idx):
	if event.type == InputEvent.MOUSE_BUTTON \
	and event.button_index == BUTTON_RIGHT \
	and event.pressed:
		emit_signal("item_collected", get_parent())

