extends SceneTree
## Checks that Godot builds exactly the same mazes as the browser game (Chrome) for the same seeds.
## Run: godot --headless --path . --script res://tests/test_maze.gd


func _init() -> void:
	var f := FileAccess.open("res://tests/fixtures/maze_chrome_ref.json", FileAccess.READ)
	var data: Dictionary = JSON.parse_string(f.get_as_text())
	var ok := 0
	var total := 0
	for m in data["mazes"]:
		total += 1
		var mine := MazeGen.generate(int(m["seed"]), int(m["lv"])).rows_as_strings()
		var ref: Array = m["grid"]
		var diff := 0
		for i in MazeGen.W:
			for j in MazeGen.W:
				if mine[i][j] != ref[i][j]:
					diff += 1
		if diff == 0:
			ok += 1
			print("PASS  level %d  seed %d" % [m["lv"], m["seed"]])
		else:
			print("FAIL  level %d  seed %d  (%d cells differ)" % [m["lv"], m["seed"], diff])
	print("%d / %d mazes match the browser game (%s)" % [ok, total, data["chrome"]])
	quit(0 if ok == total else 1)
