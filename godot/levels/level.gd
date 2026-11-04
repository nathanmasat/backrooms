class_name BRLevel
extends Node3D
## Builds one level from the maze: walls, floor, ceiling, glowing ceiling panels, fog and light.
## Real lights are expensive, so a small pool of lights follows the player and sits in the panels closest to them.

const LIGHT_POOL := 10
const CEIL_COLORS := {0: "#bdb58c", 1: "#e4eeee", 2: "#d8c2b8", 3: "#3a221a", 4: "#d6d8cc", 5: "#9c9c96",
	6: "#0a0a08", 7: "#4a5058", 8: "#d8e0dc", 9: "#0e0616"}

var maze: MazeGen
var cfg: Dictionary
var panels: Array[Vector3] = []
var _lights: Array[OmniLight3D] = []
var _light_t := 0.0
var _flicker: Array = []   # [index into panels, timer, on]
var panel_mm: MultiMeshInstance3D


func build(m: MazeGen, level_cfg: Dictionary, level: int, seed_value: int) -> void:
	maze = m
	cfg = level_cfg
	var wall_c := Color(cfg.get("w", "#b5a040"))
	var stripe_c := Color(cfg.get("s", "#a08c2a"))
	var carpet_c := Color(cfg.get("c", "#6d5e25"))
	var ceil_c := Color(CEIL_COLORS.get(level, "#bdb58c"))
	var fog_c := Color.hex((int(cfg.get("f", 0x120e00)) << 8) | 0xFF)
	var S := MazeGen.S
	var H := MazeGen.H
	var W := MazeGen.W
	var span := W * S

	# ---- environment: fog, ambient light, glow
	var env := Environment.new()
	env.background_mode = Environment.BG_COLOR
	env.background_color = fog_c
	env.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	env.ambient_light_color = Color(1.0, 0.94, 0.63)
	env.ambient_light_energy = float(cfg.get("am", 0.6)) * 0.55
	env.fog_enabled = true
	env.fog_light_color = fog_c
	env.fog_density = float(cfg.get("fd", 0.07)) * 1.4
	env.fog_sky_affect = 0.0
	env.tonemap_mode = Environment.TONE_MAPPER_FILMIC
	env.glow_enabled = true
	env.glow_intensity = 0.6
	env.glow_bloom = 0.05
	env.ssao_enabled = true
	env.ssao_intensity = 1.6
	var we := WorldEnvironment.new()
	we.environment = env
	add_child(we)

	# ---- walls (one multimesh) + their collision
	var wall_mat := StandardMaterial3D.new()
	wall_mat.albedo_texture = BRTextures.wallpaper(wall_c, stripe_c, seed_value)
	wall_mat.roughness = 0.95
	wall_mat.texture_filter = BaseMaterial3D.TEXTURE_FILTER_LINEAR_WITH_MIPMAPS_ANISOTROPIC
	var box := BoxMesh.new()
	box.size = Vector3(S, H, S)
	box.material = wall_mat
	var cells: Array[Vector2i] = []
	for i in range(-1, W + 1):
		for j in range(-1, W + 1):
			if maze.is_wall(i, j):
				# skip border cells that only touch other border cells (never seen)
				if (i < 0 or j < 0 or i >= W or j >= W) and not _touches_floor(i, j):
					continue
				cells.append(Vector2i(i, j))
	var mm := MultiMesh.new()
	mm.transform_format = MultiMesh.TRANSFORM_3D
	mm.mesh = box
	mm.instance_count = cells.size()
	var body := StaticBody3D.new()
	body.name = "Walls"
	add_child(body)
	var shape := BoxShape3D.new()
	shape.size = Vector3(S, H, S)
	for k in cells.size():
		var c := cells[k]
		var pos := Vector3(MazeGen.cell_center(c.x), H / 2.0, MazeGen.cell_center(c.y))
		mm.set_instance_transform(k, Transform3D(Basis(), pos))
		var cs := CollisionShape3D.new()
		cs.shape = shape
		cs.position = pos
		body.add_child(cs)
	var mmi := MultiMeshInstance3D.new()
	mmi.name = "WallMesh"
	mmi.multimesh = mm
	add_child(mmi)

	# ---- floor and ceiling
	var floor_mat := StandardMaterial3D.new()
	floor_mat.albedo_texture = BRTextures.carpet(carpet_c, seed_value + 1)
	floor_mat.roughness = 1.0
	floor_mat.uv1_scale = Vector3(span / 6.0, span / 6.0, 1)
	floor_mat.texture_filter = BaseMaterial3D.TEXTURE_FILTER_LINEAR_WITH_MIPMAPS_ANISOTROPIC
	var fm := PlaneMesh.new()
	fm.size = Vector2(span + 8, span + 8)
	fm.material = floor_mat
	var floor_mi := MeshInstance3D.new()
	floor_mi.mesh = fm
	floor_mi.position = Vector3(span / 2.0, 0, span / 2.0)
	add_child(floor_mi)
	var fb := StaticBody3D.new()
	var fcs := CollisionShape3D.new()
	fcs.shape = WorldBoundaryShape3D.new()
	fb.add_child(fcs)
	add_child(fb)
	var ceil_mat := StandardMaterial3D.new()
	ceil_mat.albedo_texture = BRTextures.ceiling(ceil_c, seed_value + 2)
	ceil_mat.roughness = 0.9
	ceil_mat.uv1_scale = Vector3(span / 8.0, span / 8.0, 1)
	var cm := PlaneMesh.new()
	cm.size = Vector2(span + 8, span + 8)
	cm.flip_faces = true
	cm.material = ceil_mat
	var ceil_mi := MeshInstance3D.new()
	ceil_mi.mesh = cm
	ceil_mi.position = Vector3(span / 2.0, H, span / 2.0)
	add_child(ceil_mi)

	# ---- glowing ceiling panels: on odd/odd floor cells, 70% of them (like the browser)
	var rng := RandomNumberGenerator.new()
	rng.seed = seed_value * 31 + level
	for c in maze.open_cells:
		if c.x % 2 == 1 and c.y % 2 == 1 and rng.randf() < 0.7:
			panels.append(Vector3(MazeGen.cell_center(c.x), H - 0.02, MazeGen.cell_center(c.y)))
	var pmat := StandardMaterial3D.new()
	pmat.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	pmat.albedo_color = Color(1.0, 0.965, 0.75)
	pmat.emission_enabled = true
	pmat.emission = Color(1.0, 0.95, 0.72)
	pmat.emission_energy_multiplier = 1.6
	var quad := QuadMesh.new()
	quad.size = Vector2(1.8, 0.6)
	quad.material = pmat
	var pmm := MultiMesh.new()
	pmm.transform_format = MultiMesh.TRANSFORM_3D
	pmm.use_colors = true
	pmm.mesh = quad
	pmm.instance_count = panels.size()
	var down := Basis(Vector3.RIGHT, PI / 2.0)
	for k in panels.size():
		pmm.set_instance_transform(k, Transform3D(down, panels[k]))
		pmm.set_instance_color(k, Color.WHITE)
		if rng.randf() < 0.12:
			_flicker.append([k, rng.randf() * 2.0, true])
	panel_mm = MultiMeshInstance3D.new()
	panel_mm.multimesh = pmm
	add_child(panel_mm)

	# ---- a pool of real lights that follow the player
	for k in LIGHT_POOL:
		var l := OmniLight3D.new()
		l.light_color = Color(1.0, 0.93, 0.7)
		l.light_energy = 1.25
		l.omni_range = 9.0
		l.omni_attenuation = 1.2
		l.shadow_enabled = false
		l.visible = false
		add_child(l)
		_lights.append(l)


func _touches_floor(i: int, j: int) -> bool:
	for a in range(-1, 2):
		for b in range(-1, 2):
			var x := i + a
			var y := j + b
			if x >= 0 and y >= 0 and x < MazeGen.W and y < MazeGen.W and maze.grid[x][y] == 0:
				return true
	return false


## Move the light pool to the panels nearest this point (called by the player every few frames).
func update_lights(at: Vector3, delta: float) -> void:
	# flicker a few panels (their light goes too)
	for f in _flicker:
		f[1] -= delta
		if f[1] <= 0.0:
			f[2] = not f[2]
			f[1] = (0.05 + randf() * (2.5 if randf() < 0.3 else 0.25)) if f[2] else (0.03 + randf() * 0.25)
			panel_mm.multimesh.set_instance_color(f[0], Color.WHITE if f[2] else Color(0.12, 0.11, 0.1))
	_light_t -= delta
	if _light_t > 0.0:
		return
	_light_t = 0.2
	var near: Array = []
	for k in panels.size():
		var p := panels[k]
		var d := Vector2(p.x - at.x, p.z - at.z).length_squared()
		if d < 22.0 * 22.0:
			near.append([d, k])
	near.sort_custom(func(a, b): return a[0] < b[0])
	var off := {}
	for f in _flicker:
		if not f[2]:
			off[f[0]] = true
	for i in _lights.size():
		var l := _lights[i]
		if i < near.size() and not off.has(near[i][1]):
			l.visible = true
			l.position = panels[near[i][1]] - Vector3(0, 0.3, 0)
		else:
			l.visible = false
