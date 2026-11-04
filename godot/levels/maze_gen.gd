class_name MazeGen
extends RefCounted
## The browser game's maze, rebuilt step for step: a 41 x 41 grid where 1 = wall and 0 = floor.
## Same seed + same level = the same layout as the browser game (checked by tests/test_maze.gd).

const W := 41      # cells per side
const S := 4.0     # metres per cell
const H := 3.2     # wall height in metres

var grid: Array = []        # grid[i][j], i = x cell, j = z cell
var open_cells: Array = []  # every floor cell as Vector2i(i, j)
var rng: BRRandom


static func generate(seed_value: int, level: int) -> MazeGen:
	var m := MazeGen.new()
	m._build(seed_value, level)
	return m


func _build(seed_value: int, level: int) -> void:
	rng = BRRandom.new(BRRandom.i32(seed_value + level * 7919))
	grid.clear()
	for i in W:
		var row: Array = []
		row.resize(W)
		row.fill(1)
		grid.append(row)
	# 1) a depth-first maze carved two cells at a time from (1, 1)
	grid[1][1] = 0
	var stack: Array = [Vector2i(1, 1)]
	var dirs: Array = [Vector2i(2, 0), Vector2i(-2, 0), Vector2i(0, 2), Vector2i(0, -2)]
	var shuffle := func(_a, _b) -> float: return rng.next_float() - 0.5
	while stack.size() > 0:
		var cur: Vector2i = stack[stack.size() - 1]
		var order := BRRandom.chrome_sort(dirs, shuffle)
		var found := false
		var d := Vector2i.ZERO
		for cand in order:
			var x: int = cur.x + cand.x
			var y: int = cur.y + cand.y
			if x > 0 and y > 0 and x < W - 1 and y < W - 1 and grid[x][y] == 1:
				d = cand
				found = true
				break
		if not found:
			stack.pop_back()
			continue
		grid[cur.x + d.x / 2][cur.y + d.y / 2] = 0
		grid[cur.x + d.x][cur.y + d.y] = 0
		stack.append(Vector2i(cur.x + d.x, cur.y + d.y))
	# 2) knock out 240 random walls so it isn't a perfect maze
	for k in 240:
		var x := 1 + rng.next_int(W - 2)
		var y := 1 + rng.next_int(W - 2)
		if (x + y) % 2 == 1:
			grid[x][y] = 0
	# 3) nine open 3 x 3 rooms
	for k in 9:
		var cx := 3 + 2 * rng.next_int(17)
		var cy := 3 + 2 * rng.next_int(17)
		for a in range(-1, 2):
			for b in range(-1, 2):
				grid[cx + a][cy + b] = 0
	# 4) Level 0 starts in an open area; a gap in the outer wall
	if level == 0:
		for a in range(1, 5):
			for b in range(1, 5):
				grid[a][b] = 0
	grid[0][2 if level == 0 else 1] = 0
	open_cells.clear()
	for i in W:
		for j in W:
			if grid[i][j] == 0:
				open_cells.append(Vector2i(i, j))


func is_wall(i: int, j: int) -> bool:
	return i < 0 or j < 0 or i >= W or j >= W or grid[i][j] == 1


## World position of a cell's centre (the browser's cc()).
static func cell_center(i: int) -> float:
	return (i + 0.5) * S


func rows_as_strings() -> PackedStringArray:
	var out := PackedStringArray()
	for i in W:
		var s := ""
		for j in W:
			s += str(grid[i][j])
		out.append(s)
	return out
