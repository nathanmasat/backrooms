extends Node
## What is true right now in this run: level, seed, progress. (Mirrors the browser game's SV.)

var level: int = 0
var seed_value: int = 0
var max_level: int = 0
var score: int = 0
var keycards: int = 0
var playing: bool = false


func new_seed() -> int:
	# the browser uses Date.now() % 1e9
	return int(Time.get_unix_time_from_system() * 1000.0) % 1000000000


func level_config(lv: int = -1) -> Dictionary:
	if lv < 0:
		lv = level
	var levels: Array = _data().get("levels", [])
	return levels[clampi(lv, 0, levels.size() - 1)] if levels.size() > 0 else {}


var _cache: Dictionary = {}
func _data() -> Dictionary:
	if _cache.is_empty():
		var f := FileAccess.open("res://data/levels.json", FileAccess.READ)
		if f:
			_cache = JSON.parse_string(f.get_as_text())
	return _cache
