extends TileMap

export var grid_size = Vector2(32, 32)
export var wood_count = 20

var obstacle_res = preload("res://Components/wood.tscn")

var tile_size = get_cell_size()
var tile_center = tile_size / 2

var grid = []

func _ready():
	set_process_input(true)

	grid_generate()
	add_obstacles()

func _input(event):
	if event.is_action_pressed("left_mouse"):
		if(add_entity(obstacle_res, get_mouse_tile())):
			print("Entity Added Successfully")
		else: print("Entity couldn't be added!")

	if event.is_action_pressed("mine"):
		print("attempting to mine")
		var occupant = grid_return_occupant(get_mouse_tile())
		if (occupant != null):
			remove_entity(occupant)
		else: print("nothing to mine")

func grid_generate():
	print("generating grid...")
	for x in range(grid_size.x):
		grid.append([])
		for y in range(grid_size.y):
			grid[x].append(null)

func add_obstacles():
	print("adding obstacles...")
	var positions = []

	var num_placed = 0

	while num_placed < wood_count:
		var random_x = randi() % int(grid_size.x)
		var random_y = randi() % int(grid_size.y)
		var grid_pos = Vector2(random_x, random_y)

		print("grid pos = (", grid_pos.x, ", ", grid_pos.y, ")")

		if add_entity(obstacle_res, grid_pos):
			num_placed = num_placed + 1
			print("obstacle added")

func add_entity(entity, entity_pos):
	print("add_entity()")
	if grid_return_occupant(entity_pos) == null:
		var entity_instance = entity.instance()
		entity_instance.position = map_to_world(entity_pos) + tile_center

		add_child(entity_instance)
		grid[entity_pos.x][entity_pos.y] = entity_instance.name
		
		print(entity_instance.name)
		print("entity grid position = (", entity_pos.x, ", ", entity_pos.y, ")")

		print("entity added")
		return(true)
	else:
		print("cell not available")
		return(false) # Failure

func remove_entity(entity_id):
	print("remove_entity()")
	for x in range(grid_size.x):
		for y in range(grid_size.y):
			if grid[x][y] == entity_id:
				var entity = get_node(grid[x][y])
				print("entity: ", entity.name)
				print("position: (", x, ", ", y, ")")

				grid[x][y] = null
				entity.queue_free()
				print("successfully removed entity")
				return(true)

func grid_return_occupant(pos):
	return(grid[pos.x][pos.y])

func get_mouse_tile():
	return(world_to_map(get_global_mouse_position()))
