extends TileMap

var Types = preload("res://Scripts/type.gd").new().Types

export var grid_size = Vector2(32, 32)
export var wood_count = 20

var tile_size = get_cell_size()
var tile_center = tile_size / 2

var grid = []

func _ready():
	set_process_input(true)

	grid_generate()
	add_obstacles()

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

		if add_entity("wood", grid_pos):
			num_placed = num_placed + 1
	print("entities added")

func add_entity(entity_type, entity_pos):
	if grid_return_occupant(entity_pos) == null:
		var entity_instance = load(Types[entity_type]).instance()
		
		entity_instance.position = map_to_world(entity_pos) + tile_center
		var entity_name = str(entity_type, "-", entity_pos.x, ",", entity_pos.y)
		entity_instance.name = entity_name
		
		add_child(entity_instance)
		grid[entity_pos.x][entity_pos.y] = entity_instance.name
		
		return(true)
	else:
		print("cell not available")
		return(false) # Failure

func remove_entity(entity_id):
	print("remove_entity()")
	if entity_id != null:
		var splitted_entity_id = entity_id.split("-")
	
		var entity_position = splitted_entity_id[1].split(",")
		
		var entity_x = int(entity_position[0])
		var entity_y = int(entity_position[1])
		var entity_type = splitted_entity_id[0]
	
		if grid[entity_x][entity_y] == entity_id:
			var entity = get_node(entity_id)
			grid[entity_x][entity_y] = null
			entity.queue_free()
			return(true)
	print("Entity Couldn't be Removed")
	return(false)


func grid_return_occupant(pos):
	return(grid[pos.x][pos.y])

func get_mouse_tile():
	return(world_to_map(get_global_mouse_position()))
