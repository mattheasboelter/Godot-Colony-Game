extends Node2D

var clickable = preload("res://Components/clickables.scn")

onready var root = get_node("/root/Root")

export(int) var slots = 1
export(int) var stack_size = 10

var count = 0
var i = 0

func _ready():
	set_process_input(true)

func _input(event):
	if(event.type == InputEvent.MOUSE_BUTTON):
		if(event.button_index == BUTTON_LEFT && event.pressed):
			if(count > 0):
				var item = clickable.instance()
				item.set_name(str("item_", i))
				item.set_pos(get_global_mouse_pos())
				print(get_global_mouse_pos())
				root.add_child(item)
				count = count - 1
				print(count)

func get_item_num():
	i = i + 1
	return(i -1)

func _on_item_collected(item):
	if(count < stack_size):
		count = count + 1
		print(count)
		item.queue_free()
	else:
		print("inventory full")
