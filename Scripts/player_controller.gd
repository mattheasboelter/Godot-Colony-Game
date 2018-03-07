### Player Controller

extends KinematicBody2D

var Types = preload("res://Scripts/type.gd").new().Types

var wood_res = preload("res://Components/wood.tscn")

onready var grid = get_node("/root/Root/Grid/")
var inventory

# _ready() is run when the node is added to the scene
func _ready():
	self.set_process(true);
	
	var inventory = $Inventory

func _process(delta):

	# Check if a certain key is pressed...
	if (Input.is_key_pressed(KEY_D)):
		# And move self five pixels in the corresponding direction
		self.move_and_slide(Vector2(200, 0))

	if (Input.is_key_pressed(KEY_A)):
		self.move_and_slide(Vector2(-200, 0))
	if (Input.is_key_pressed(KEY_W)):
		self.move_and_slide(Vector2(0, -200))
	if (Input.is_key_pressed(KEY_S)):
		self.move_and_slide(Vector2(0, 200))

func _input(event):
	for i in range($Inventory.hotbar_size):
		if event.is_action_pressed(str("inventory_", i + 1)):
			if $Inventory.selected != i:
				$Inventory.select(i)
			else:
				$Inventory.deselect()

	if event.is_action_pressed("deselect"):
		$Inventory.deselect()
	if event.is_action_pressed("left_mouse"):
		if $Inventory.selected != null:
			if grid.add_entity($Inventory.selected_type(), grid.get_mouse_tile()):
				$Inventory.remove()
	if event.is_action_pressed("mine"):	
		if $Inventory.has_space():
			print("mining")
			var cell_occupant = grid.grid_return_occupant(grid.get_mouse_tile())

			if cell_occupant != null:
				var occupant_type = cell_occupant.split("-")[0]
				if grid.remove_entity(cell_occupant):
					$Inventory.add(occupant_type)
					print($Inventory.inventory.size())
	


