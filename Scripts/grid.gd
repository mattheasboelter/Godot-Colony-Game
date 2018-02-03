extends TileMap

export var grid_size = Vector2(32, 32)
export var wood_count = 20

var obstacle_res = preload("res://Components/clickables.tscn")

var tile_size = get_cell_size()
var tile_center = tile_size / 2

var grid = []

func _ready():
	set_process_input(true)

	grid_generate()
	add_obstacles()

func _input(event):
	if(event.is_action_pressed("left_mouse")):
			print("left mouse button")
			print(get_mouse_tile())
			if(add_entity(obstacle_res, get_mouse_tile())):
				print("Entity Added Successfully")
			else: print("Entity couldn't be added!")

	if (event.is_action_pressed("mine")):
		print("mine")

		var occupant = grid_return_occupant(get_mouse_tile())
		print(occupant)
		if (occupant != null):
			remove_entity(occupant)

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

	while (num_placed < wood_count):
		var random_x = randi() % int(grid_size.x)
		var random_y = randi() % int(grid_size.y)
		var grid_pos = Vector2(random_x, random_y)

		print("grid pos = (", grid_pos.x, ", ", grid_pos.y, ")")

		if(add_entity(obstacle_res, grid_pos)):
			num_placed = num_placed + 1
			print("obstacle added")

func add_entity(entity, entity_pos):
	print("add_entity()")
	if(grid_cell_available(entity_pos)):
		var entity_instance = entity.instance()
		entity_instance.position = map_to_world(entity_pos) + tile_center


		print("new entity")
		print(entity_instance.name)
		print(entity_pos)
		print(map_to_world(entity_pos))

		add_child(entity_instance)
		grid[entity_pos.x][entity_pos.y] = entity_instance.name

		print("entity added")
		return(true)
	else:
		print("cell not available")
		return(false) # Failure

func remove_entity(entity):
	for x in range(grid_size.x):
		for y in range(grid_size.y):
			if (grid[x][y] == entity):
				var entity_instance = get_node(grid[x][y])
				print("instance: ", entity_instance.name)
				print("grid instance: ", grid[x][y])
				print("x = ", x, ", y = ", y)

				grid[x][y] = null
				entity_instance.queue_free()

func grid_return_occupant(pos):
	return(grid[pos.x][pos.y])

func grid_cell_available(pos):
	# If the Cell is inside the grid
	if (pos.x < grid_size.x && pos.x >=0):
		if (pos.y < grid_size.y && pos.y >=0):
			# If the cell is empty
			if (grid[pos.x][pos.y] == null):
				print("cell available")
				return(true)
	else:
		print("cell not available")
		return(false)

func get_mouse_tile():
	return(world_to_map(get_global_mouse_position()))
