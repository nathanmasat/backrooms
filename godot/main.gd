extends Node3D
## Starts a level: makes the maze from the seed, builds it, drops the player in, and shows the HUD.
## Command line (optional): -- --level=0 --seed=12345
## Test screenshot:          -- --shot=res://shot.png --look=<yaw> (saves a picture after a few frames, then quits)

var level_node: BRLevel
var player: BRPlayer
var hud: BRHud
var _shot := ""
var _shot_frames := 0


func _ready() -> void:
	var args := _args()
	GameState.level = int(args.get("level", 0))
	GameState.seed_value = int(args.get("seed", GameState.new_seed()))
	_shot = str(args.get("shot", ""))
	var cfg := GameState.level_config()
	var maze := MazeGen.generate(GameState.seed_value, GameState.level)
	level_node = BRLevel.new()
	level_node.name = "Level"
	add_child(level_node)
	level_node.build(maze, cfg, GameState.level, GameState.seed_value)
	player = BRPlayer.create()
	add_child(player)
	player.level = level_node
	# the browser game's start: Level 0 at (10, 10) facing -90°, other levels at (6, 6) facing +90°
	var data: Dictionary = GameState._data()
	var st: Dictionary = data.get("start", {}).get("lv0" if GameState.level == 0 else "other", {"x": 10, "z": 10, "yaw": 0})
	player.position = Vector3(float(st["x"]), 0.05, float(st["z"]))
	player.yaw = float(st["yaw"])
	if args.has("look"):
		player.yaw = float(args["look"])
	hud = BRHud.new()
	add_child(hud)
	hud.set_level_name(str(cfg.get("n", "LEVEL %d" % GameState.level)))
	player.stats_changed.connect(hud.set_stats)
	EventBus.level_started.emit(GameState.level, GameState.seed_value)
	hud.show_message("You wake up on damp carpet. The lights hum. You are not alone.", 6.0)
	print("Level %d, seed %d, %d floor cells" % [GameState.level, GameState.seed_value, maze.open_cells.size()])
	if _shot != "":
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED   # hides the start screen for the picture


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and Input.mouse_mode != Input.MOUSE_MODE_CAPTURED:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	elif event.is_action_pressed("pause"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE


func _process(_delta: float) -> void:
	if _shot == "":
		return
	_shot_frames += 1
	if _shot_frames == 45:
		var img := get_viewport().get_texture().get_image()
		img.save_png(_shot)
		print("saved ", _shot)
		get_tree().quit()


func _args() -> Dictionary:
	var out := {}
	for a in OS.get_cmdline_user_args():
		if a.begins_with("--") and a.contains("="):
			var kv := a.substr(2).split("=", true, 1)
			out[kv[0]] = kv[1]
	return out
