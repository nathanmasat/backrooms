extends Node
## Player settings and the controls (the same default keys as the browser game).

var mouse_sensitivity: float = 1.0
var invert_y: bool = false
var volume: float = 0.9

const KEYS := {
	"move_forward": [KEY_W, KEY_UP],
	"move_back": [KEY_S, KEY_DOWN],
	"move_left": [KEY_A, KEY_LEFT],
	"move_right": [KEY_D, KEY_RIGHT],
	"sprint": [KEY_SHIFT],
	"crouch": [KEY_C],
	"jump": [KEY_SPACE],
	"flashlight": [KEY_T],
	"interact": [KEY_F],
	"grab": [KEY_E],
	"scanner": [KEY_Q],
	"map": [KEY_M],
	"lean_left": [KEY_Z],
	"lean_right": [KEY_X],
	"pause": [KEY_ESCAPE],
}


func _ready() -> void:
	for action in KEYS:
		if not InputMap.has_action(action):
			InputMap.add_action(action)
		for k in KEYS[action]:
			var ev := InputEventKey.new()
			ev.physical_keycode = k
			InputMap.action_add_event(action, ev)
	load_settings()


func load_settings() -> void:
	var cfg := ConfigFile.new()
	if cfg.load("user://settings.cfg") == OK:
		mouse_sensitivity = cfg.get_value("controls", "mouse_sensitivity", mouse_sensitivity)
		invert_y = cfg.get_value("controls", "invert_y", invert_y)
		volume = cfg.get_value("audio", "volume", volume)


func save_settings() -> void:
	var cfg := ConfigFile.new()
	cfg.set_value("controls", "mouse_sensitivity", mouse_sensitivity)
	cfg.set_value("controls", "invert_y", invert_y)
	cfg.set_value("audio", "volume", volume)
	cfg.save("user://settings.cfg")
