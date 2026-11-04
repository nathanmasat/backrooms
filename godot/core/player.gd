class_name BRPlayer
extends CharacterBody3D
## The explorer: walk, sprint (stamina), crouch, jump, look around, flashlight with a battery.
## Numbers match the browser game: walk 3 m/s, sprint 5.5, crouch 1.5, jump 6.7 m/s with gravity 20.

signal stats_changed(stamina: float, battery: float, light_on: bool)

const WALK := 3.0
const SPRINT := 5.5
const CROUCH := 1.5
const JUMP := 6.7
const GRAVITY := 20.0
const EYE := 1.65
const EYE_CROUCH := 1.0

var stamina := 100.0
var battery := 100.0
var tired := false
var light_on := true
var yaw := 0.0
var pitch := 0.0
var level: BRLevel
var _bob := 0.0
var _step_t := 0.0
var _eye := EYE
var force_play := false   # tests drive the player without a captured mouse

@onready var cam: Camera3D = $Camera
@onready var flashlight: SpotLight3D = $Camera/Flashlight


static func create() -> BRPlayer:
	var p := BRPlayer.new()
	p.name = "Player"
	var col := CollisionShape3D.new()
	var cap := CapsuleShape3D.new()
	cap.radius = 0.35
	cap.height = 1.75
	col.shape = cap
	col.position.y = 0.875
	p.add_child(col)
	var c := Camera3D.new()
	c.name = "Camera"
	c.fov = 75.0
	c.near = 0.05
	c.far = 90.0
	c.position.y = EYE
	p.add_child(c)
	var f := SpotLight3D.new()
	f.name = "Flashlight"
	f.light_color = Color(1.0, 0.98, 0.88)
	f.light_energy = 3.2
	f.spot_range = 42.0
	f.spot_angle = 30.0
	f.spot_angle_attenuation = 1.4
	f.shadow_enabled = true
	f.position = Vector3(0.18, -0.2, 0)
	c.add_child(f)
	return p


func _ready() -> void:
	floor_max_angle = deg_to_rad(50)
	rotation.y = yaw


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		var s := 0.0022 * Settings.mouse_sensitivity
		yaw -= event.relative.x * s
		pitch -= event.relative.y * s * (-1.0 if Settings.invert_y else 1.0)
		pitch = clampf(pitch, -1.3, 1.3)
	elif event.is_action_pressed("flashlight"):
		if battery > 0.0:
			light_on = not light_on
			AudioManager.blip(1800.0, 0.03, -18.0)


func _physics_process(delta: float) -> void:
	var playing := force_play or Input.mouse_mode == Input.MOUSE_MODE_CAPTURED
	var input := Vector2.ZERO
	if playing:
		input = Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var crouching := playing and Input.is_action_pressed("crouch")
	var moving := input.length() > 0.1
	var sprinting := playing and Input.is_action_pressed("sprint") and moving and not crouching and not tired and stamina > 0.0
	# stamina (same rates as the browser game)
	if sprinting:
		stamina -= 15.0 * delta
	else:
		stamina = minf(100.0, stamina + (8.0 if moving else 14.0) * delta)
	if stamina <= 0.0:
		tired = true
	if tired and stamina > 30.0:
		tired = false
	var speed := CROUCH if crouching else (SPRINT if sprinting else WALK)
	# smooth acceleration, like the browser game
	var basis_y := Basis(Vector3.UP, yaw)
	var wish := basis_y * Vector3(input.x, 0, input.y)
	if wish.length() > 1.0:
		wish = wish.normalized()
	var target := wish * speed
	var acc := 1.0 - exp(-(11.0 if moving else 14.0) * delta)
	velocity.x = lerpf(velocity.x, target.x, acc)
	velocity.z = lerpf(velocity.z, target.z, acc)
	if is_on_floor():
		if playing and Input.is_action_just_pressed("jump") and not crouching:
			velocity.y = JUMP
			AudioManager.blip(220.0, 0.06, -20.0)
	else:
		velocity.y -= GRAVITY * delta
	move_and_slide()
	# camera: crouch height, head bob, look
	_eye = lerpf(_eye, EYE_CROUCH if crouching else EYE, minf(1.0, delta * 8.0))
	var spd := Vector2(velocity.x, velocity.z).length()
	_bob += delta * spd * 2.2
	var bob_amt := minf(1.0, spd / 3.0) * (1.7 if sprinting else 1.0)
	rotation.y = yaw
	cam.rotation.x = pitch
	cam.position.y = _eye + sin(_bob) * 0.04 * bob_amt
	cam.position.x = sin(_bob * 0.5) * 0.014 * bob_amt
	var tf := 75.0 + (6.0 if sprinting and spd > 3.5 else 0.0)
	cam.fov = lerpf(cam.fov, tf, minf(1.0, delta * 5.0))
	# footsteps
	if is_on_floor() and spd > 0.6:
		_step_t -= delta
		if _step_t <= 0.0:
			_step_t = 0.8 if crouching else (0.32 if sprinting else 0.53)
			AudioManager.blip(90.0 + randf() * 30.0, 0.05, -24.0 if crouching else -16.0)
	# flashlight battery
	if light_on and battery > 0.0:
		battery = maxf(0.0, battery - 0.3 * delta)
		if battery == 0.0:
			light_on = false
			EventBus.message.emit("The flashlight dies.", 3.0)
	flashlight.visible = light_on
	if light_on and battery < 10.0:
		flashlight.light_energy = 3.2 if randf() < 0.8 else 0.3
	if level:
		level.update_lights(global_position, delta)
	stats_changed.emit(stamina, battery, light_on)
