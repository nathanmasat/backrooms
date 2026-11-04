extends Node
## Walks the player into a wall (must stop), along a corridor (must move) and jumps (must go up and land).
## Run: godot --headless --path . res://tests/test_player.tscn

var main: Node
var frame := 0
var phase := 0
var p: BRPlayer
var start := Vector3.ZERO
var peak := 0.0
var fails := 0


func _ready() -> void:
	main = load("res://main.tscn").instantiate()
	add_child(main)


func _physics_process(_delta: float) -> void:
	frame += 1
	if frame == 5:
		p = main.player
		p.force_play = true
		var m: MazeGen = main.level_node.maze
		# find a floor cell with a wall straight to its +x side
		for c in m.open_cells:
			if c.x > 1 and m.is_wall(c.x + 1, c.y) and not m.is_wall(c.x - 1, c.y):
				p.position = Vector3(MazeGen.cell_center(c.x), 0.05, MazeGen.cell_center(c.y))
				p.yaw = -PI / 2.0   # facing +x
				start = p.position
				break
		Input.action_press("move_forward")
	if frame == 150:
		Input.action_release("move_forward")
		var wall_x := start.x + MazeGen.S / 2.0
		var ok := p.position.x < wall_x - 0.3
		print(("PASS" if ok else "FAIL") + "  walking into a wall stops at x=%.2f (wall face at %.2f)" % [p.position.x, wall_x])
		if not ok: fails += 1
		var moved := p.position.x - start.x
		print(("PASS" if moved > 0.8 else "FAIL") + "  walked %.2f m up to the wall" % moved)
		if moved <= 0.8: fails += 1
		Input.action_press("jump")
	if frame == 152:
		Input.action_release("jump")
	if frame > 150 and frame < 230:
		peak = maxf(peak, p.position.y)
	if frame == 230:
		var ok := peak > 0.9 and p.position.y < 0.1
		print(("PASS" if ok else "FAIL") + "  jump went up %.2f m and landed (y=%.2f)" % [peak, p.position.y])
		if not ok: fails += 1
		print("player tests: %s" % ("ALL PASS" if fails == 0 else "%d FAILED" % fails))
		get_tree().quit(fails)
