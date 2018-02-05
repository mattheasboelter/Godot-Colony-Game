### Player Controller

extends KinematicBody2D

var wood_res = preload("res://Components/wood.tscn")

onready var grid = get_node("/root/Root/Grid/")
var inventory

# _ready() is run when the node is added to the scene
func _ready():
	# Tell godot to call _process() life cycle function when in game loop
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
	if event.is_action_pressed("left_mouse"):
		if $Inventory.item_count("pizza"):
			if grid.add_entity(wood_res, grid.get_mouse_tile()):
				$Inventory.remove("pizza")
				print($Inventory.inventory.size())
	if event.is_action_pressed("mine"):
		if $Inventory.has_space():
			var cell_occupant = grid.grid_return_occupant(grid.get_mouse_tile())
			if grid.remove_entity(cell_occupant):
				$Inventory.add("pizza")
				print($Inventory.inventory.size())
	


