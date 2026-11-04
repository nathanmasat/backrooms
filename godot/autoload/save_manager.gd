extends Node
## Saves (user://save.json). Later: import the browser game's "Export save" file so progress carries over.

const PATH := "user://save.json"


func save_game() -> void:
	var d := {"version": 1, "level": GameState.level, "max_level": GameState.max_level, "score": GameState.score}
	var f := FileAccess.open(PATH, FileAccess.WRITE)
	if f:
		f.store_string(JSON.stringify(d))


func load_game() -> bool:
	if not FileAccess.file_exists(PATH):
		return false
	var f := FileAccess.open(PATH, FileAccess.READ)
	var d = JSON.parse_string(f.get_as_text())
	if typeof(d) != TYPE_DICTIONARY:
		return false
	GameState.level = int(d.get("level", 0))
	GameState.max_level = int(d.get("max_level", 0))
	GameState.score = int(d.get("score", 0))
	return true
