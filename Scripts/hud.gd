extends Control

onready var label = Label.new()

func _ready():
	var inventory = get_node("../Inventory")
	inventory.connect("update_inventory", self, "_update_inventory")

	_update_inventory(inventory.inventory, inventory.selected)
	
	add_child(label)

func _update_inventory(inventory, selected):
	print("update inventory()")
	print(inventory)
	print(selected)
	var label_text = ""
	
	var index = 0
	for item in inventory:
		print(item)
		if selected == index:
			print("selected item")
			label_text += "|" + item + "|" + ", "
		else:
			label_text += item + ", "
		index = index + 1
	
	label.text = label_text
