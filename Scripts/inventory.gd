extends Node

signal update_inventory

export var inventory_size = 5
export var hotbar_size = 5

var inventory = []
var selected = null

func _ready():
	inventory.append("wood_wall")
	inventory.append("wood_wall")
	inventory.append("wood_wall")

func item_count(resource):
	return(inventory.count(resource))

func select(index):
	print("selecting ", index)
	selected = index
	emit_signal("update_inventory", inventory, selected)

func deselect():
	selected = null
	emit_signal("update_inventory", inventory, selected)

func selected_type():
	if selected != null:
		print(inventory[selected])
		return(inventory[selected])
	else:
		return(null)

func add(resource):
	print("adding to inventory...")

	if inventory.size() < inventory_size:
		inventory.append(resource)
		emit_signal("update_inventory", inventory, selected)
		print("added to inventory")
		return(true)
	else:
		print("no space left in inventory")
		return(false)

func remove():
	print("removing from inventory...")

	if selected != null:
		inventory.remove(selected)
		print("item removed")

		if selected >= inventory.size():
			selected = null
	
		emit_signal("update_inventory", inventory, selected)
	else:
		print("nothing to remove")

func has_space():
	if inventory.size() < inventory_size:
		return(true)
	else: return(false)

func print_items():
	for item in inventory:
		print(item)

func get_size():
	return inventory.size()
