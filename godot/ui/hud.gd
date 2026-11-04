class_name BRHud
extends CanvasLayer
## On-screen info: level name, stamina and battery bars, messages, and the start / pause screen.

var _level: Label
var _msg: Label
var _msg_t := 0.0
var _stam: ProgressBar
var _batt: ProgressBar
var _info: Label
var overlay: Control

const YELLOW := Color("#e4d56a")


func _ready() -> void:
	var root := Control.new()
	root.set_anchors_preset(Control.PRESET_FULL_RECT)
	root.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(root)
	_level = _label(root, 18, YELLOW)
	_place(_level, 1, 0, 1, 0, -620, 20, -24, 54)
	_level.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
	_level.modulate.a = 0.8
	var box := VBoxContainer.new()
	root.add_child(box)
	_place(box, 0, 1, 0, 1, 24, -170, 300, -24)
	_label(box, 14, YELLOW).text = "STAMINA"
	_stam = _bar(box, Color("#cccc99"))
	_label(box, 14, YELLOW).text = "BATTERY"
	_batt = _bar(box, Color("#88cc88"))
	_info = _label(box, 14, Color("#cfe6ff"))
	_msg = _label(root, 20, Color.WHITE)
	_place(_msg, 0.5, 1, 0.5, 1, -700, -230, 700, -180)
	_msg.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	_msg.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	var dot := ColorRect.new()
	dot.color = Color(1, 1, 1, 0.5)
	dot.size = Vector2(4, 4)
	root.add_child(dot)
	_place(dot, 0.5, 0.5, 0.5, 0.5, -2, -2, 2, 2)
	# start / pause screen
	overlay = ColorRect.new()
	(overlay as ColorRect).color = Color(0, 0, 0, 0.82)
	overlay.set_anchors_preset(Control.PRESET_FULL_RECT)
	add_child(overlay)
	var v := VBoxContainer.new()
	v.alignment = BoxContainer.ALIGNMENT_CENTER
	overlay.add_child(v)
	_place(v, 0.5, 0.5, 0.5, 0.5, -700, -220, 700, 220)
	var t := _label(v, 54, YELLOW)
	t.text = "THE BACKROOMS: DON'T LOOK BACK"
	t.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	var sub := _label(v, 18, Color(0.85, 0.82, 0.6))
	sub.text = "Godot preview · Level 0 · a game by Nathan"
	sub.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	var keys := _label(v, 17, Color(0.9, 0.9, 0.85))
	keys.text = "\nWASD move · SHIFT sprint · C crouch · SPACE jump · T flashlight · ESC pause\n\n[ CLICK TO BEGIN ]"
	keys.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	EventBus.message.connect(show_message)


## Pin a control to anchor points (0..1 of the screen) with pixel offsets from them.
func _place(c: Control, al: float, at: float, ar: float, ab: float, l: float, t: float, r: float, b: float) -> void:
	c.anchor_left = al
	c.anchor_top = at
	c.anchor_right = ar
	c.anchor_bottom = ab
	c.offset_left = l
	c.offset_top = t
	c.offset_right = r
	c.offset_bottom = b


func _label(parent: Node, size: int, col: Color) -> Label:
	var l := Label.new()
	l.add_theme_font_size_override("font_size", size)
	l.add_theme_color_override("font_color", col)
	l.add_theme_color_override("font_shadow_color", Color(0, 0, 0, 0.9))
	l.add_theme_constant_override("shadow_offset_x", 2)
	l.add_theme_constant_override("shadow_offset_y", 2)
	l.mouse_filter = Control.MOUSE_FILTER_IGNORE
	parent.add_child(l)
	return l


func _bar(parent: Node, col: Color) -> ProgressBar:
	var b := ProgressBar.new()
	b.custom_minimum_size = Vector2(240, 8)
	b.show_percentage = false
	b.max_value = 100
	var fg := StyleBoxFlat.new()
	fg.bg_color = col
	var bg := StyleBoxFlat.new()
	bg.bg_color = Color(0.13, 0.13, 0.13, 0.85)
	b.add_theme_stylebox_override("fill", fg)
	b.add_theme_stylebox_override("background", bg)
	b.mouse_filter = Control.MOUSE_FILTER_IGNORE
	parent.add_child(b)
	return b


func set_level_name(n: String) -> void:
	_level.text = n


func set_stats(stamina: float, battery: float, light_on: bool) -> void:
	_stam.value = stamina
	_batt.value = battery
	_info.text = "[LIGHT ON]" if light_on else ""


func show_message(text: String, seconds: float = 4.0) -> void:
	_msg.text = text
	_msg_t = seconds


func _process(delta: float) -> void:
	if _msg_t > 0.0:
		_msg_t -= delta
		if _msg_t <= 0.0:
			_msg.text = ""
	overlay.visible = Input.mouse_mode != Input.MOUSE_MODE_CAPTURED
