extends Node

signal hotbar_update

export var inventory_size = 10
export var hotbar_size = 10

var inventory = []
var selected = null

func _ready():
	inventory.append("wood_wall")
	inventory.append("wood_wall")
	inventory.append("wood_wall")
	
	for i in range(inventory_size):
		inventory.append(null)

func item_count(resource):
	return(inventory.count(resource))

func select(index):
	if inventory[index] != null:
		print("selecting ", index)
		selected = index
		emit_signal("hotbar_update", self)
	else:
		selected = null

func deselect():
	selected = null
	emit_signal("hotbar_update", self)

func selected_type():
	if selected != null:
		print(inventory[selected])
		return(inventory[selected])
	else:
		return(null)

func add(resource):
	print("adding to inventory...")
	
	for i in range(inventory.size()):
		if inventory[i] == null:
			print("slot ", i, "== null")
			inventory[i] = resource
			emit_signal("hotbar_update", self)
			print("added to inventory")
			return(true)
	
	return(false)

func remove():
	print("removing from inventory...")

	if selected != null:
		inventory[selected] = null
		selected = null
		print("item removed")
	
		emit_signal("hotbar_update", self)
	else:
		print("nothing to remove")

func has_space():
	for i in range(inventory.size()):
		if inventory[i] == null:
			return(true)
	return(false)


func print_items():
	for item in inventory:
		print(item)

func get_size():
	return inventory.size()
