extends Node

export var inventory_size = 5

var inventory = []

func item_count(resource):
	return(inventory.count(resource))

func add(resource):
	print("adding to inventory...")

	if inventory.size() < inventory_size:
		inventory.append(resource)
		print("added to inventory")
		return(true)
	else:
		print("no space left in inventory")
		return(false)

func remove(resource):
	print("removing from inventory...")

	if inventory.count(resource) > 0:
		inventory.erase(resource)
		print("item removed")
	else:
		print("item not in inventory")

func has_space():
	if inventory.size() < inventory_size:
		return(true)
	else: return(false)

func print_items():
	for item in inventory:
		print(item)

func get_size():
	return inventory.size()
