extends Control

onready var label = Label.new()

func _ready():
	get_node("../Inventory").connect("update_inventory", self, "_update_inventory")
	
	
	add_child(label)

func _update_inventory(inventory):
	print("update inventory()")
	print(inventory)
	var label_text = ""
	
	for item in inventory:
		print(item)
		label_text += item + ", "
	
	label.text = label_text
