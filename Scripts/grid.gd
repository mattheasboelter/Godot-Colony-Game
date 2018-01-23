extends TileMap

var obstacle_res = preload("res://Components/clickables.scn")

var tile_size = get_cell_size()
var tile_center = tile_size / 2
var grid_size = Vector2(16, 16)

var grid = []

func _ready():
	for x in range(grid_size.x):
		grid.append([])
		for y in range(grid_size.y):
			grid[x].append(null)
	
	# Obstacles
	var positions = []

	for x in range(5):
		var placed = false
		while(!placed):
			var random_x = randi() % int(grid_size.x)
			var random_y = randi() % int(grid_size.y)
			var grid_pos = Vector2(random_x, random_y)

			if(!grid[grid_pos.x][grid_pos.y]):
				positions.append(grid_pos)
				placed = true
	
	for pos in positions:
		var obstacle_instance = obstacle_res.instance()
		obstacle_instance.set_pos(map_to_world(pos) + tile_center)
		grid[pos.x][pos.y] = obstacle_instance.get_name()
		add_child(obstacle_instance)

func get_cell_centent(pos=Vector2()):
	return grid[pos.x][pos.y]

func is_cell_vacant(pos=Vector2(), direction=Vector2()):
	var grid_pos = world_to_map(pos) + direction

	if (grid_pos.x < grid_size.x && grid_pos.x >=0):
		if(grid_pos.y < grid_size.y && grid_pos.y >=0):
			if grid[grid_pos.x][grid_pos.y] == null:
				return true
	else: return false

func update_child_pos(new_pos, direction, type):
	var grid_pos = world_to_map(new_pos)
	print(grid_pos)
	grid[grid_pos.x][grid_pos.y] = null

	var new_grid_pos = grid_pos + direction
	grid[new_grid_pos.x][new_grid_pos.y] = type

	var target_pos = map_to_world(new_grid_pos) + tile_center
	return target_pos
