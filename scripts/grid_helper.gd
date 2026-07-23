class_name GridHelper


static func adjacent(grid_pos:Vector2i):
	return [grid_pos + Vector2i(1,0), grid_pos + Vector2i(-1,0), grid_pos + Vector2i(0,1), grid_pos + Vector2i(0,-1)]

static func diagonal(grid_pos:Vector2i):
	return [grid_pos + Vector2i(1,1), grid_pos + Vector2i(-1,1), grid_pos + Vector2i(1,-1), grid_pos + Vector2i(-1,-1)]

static func eightaround(grid_pos:Vector2i):
	return (adjacent(grid_pos) + diagonal(grid_pos))
