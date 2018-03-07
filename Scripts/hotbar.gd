extends PanelContainer

func _ready():
	var inventory = get_node("../../Player/Inventory")
	inventory.connect("hotbar_update", self, "_hotbar_update")
	
	_hotbar_update(inventory)

func _hotbar_update(inventory):
	var i = 0
	while i < inventory.inventory_size:
		var hotbar_element = inventory.inventory[i]
		
		var selected = false
		if i == inventory.selected:
			selected = true

		var node_name = str("MarginContainer/Item Grid/Slot ", i + 1)
		get_node(node_name).update(hotbar_element, selected)

		i = i + 1

