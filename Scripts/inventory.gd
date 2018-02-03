extends Node

export var inventory_size = Vector2(10, 5)

var inventory = []

func _ready():
	initialize_inventory()

func _inventory_add(resource):
	print("adding to inventory...")

func _inventory_remove(resource):
	print("removing from inventory...")

func initialize_inventory():
	print("initializing inventory...")

	for x in range(inventory_size.x):
		grid.append([])
		for y in range(inventory_size.y):
			grid[x].append(null)
