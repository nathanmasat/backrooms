class_name BRTextures
extends RefCounted
## The level's wallpaper, carpet and ceiling tiles, painted in code from the level's colours
## (so the project needs no image files yet). Real CC0 textures can replace these later.


static func _noise(img: Image, rng: RandomNumberGenerator, amount: float, count: int, size: int = 2) -> void:
	var w := img.get_width()
	var h := img.get_height()
	for k in count:
		var x := rng.randi_range(0, w - size)
		var y := rng.randi_range(0, h - size)
		var dark := rng.randf() < 0.6
		for a in size:
			for b in size:
				var c := img.get_pixel(x + a, y + b)
				var f := rng.randf() * amount
				c = c.darkened(f) if dark else c.lightened(f * 0.5)
				img.set_pixel(x + a, y + b, c)


static func _tex(img: Image) -> ImageTexture:
	img.generate_mipmaps()
	return ImageTexture.create_from_image(img)


## Yellow wallpaper with faint vertical stripes, a dark baseboard and damp stains.
static func wallpaper(base: Color, stripe: Color, seed_value: int = 7) -> ImageTexture:
	var rng := RandomNumberGenerator.new()
	rng.seed = seed_value
	var n := 256
	var img := Image.create(n, n, false, Image.FORMAT_RGB8)
	for x in n:
		var on := (x / 16) % 2 == 0
		var col := base if on else base.lerp(stripe, 0.55)
		for y in n:
			img.set_pixel(x, y, col)
	_noise(img, rng, 0.12, 2600)
	# damp stains
	for s in 6:
		var cx := rng.randi_range(0, n - 1)
		var cy := rng.randi_range(n / 3, n - 1)
		var r := rng.randi_range(10, 34)
		for x in range(cx - r, cx + r):
			for y in range(cy - r, cy + r):
				if x < 0 or y < 0 or x >= n or y >= n:
					continue
				var d := Vector2(x - cx, y - cy).length() / r
				if d < 1.0:
					img.set_pixel(x, y, img.get_pixel(x, y).darkened((1.0 - d) * 0.18))
	# baseboard
	for x in n:
		for y in range(n - 12, n):
			img.set_pixel(x, y, base.darkened(0.55))
	return _tex(img)


## Damp, mottled carpet.
static func carpet(base: Color, seed_value: int = 11) -> ImageTexture:
	var rng := RandomNumberGenerator.new()
	rng.seed = seed_value
	var n := 256
	var img := Image.create(n, n, false, Image.FORMAT_RGB8)
	img.fill(base)
	_noise(img, rng, 0.22, 14000, 1)
	_noise(img, rng, 0.10, 1800, 4)
	return _tex(img)


## Office ceiling tiles: a light grid with grubby tiles.
static func ceiling(base: Color, seed_value: int = 13) -> ImageTexture:
	var rng := RandomNumberGenerator.new()
	rng.seed = seed_value
	var n := 256
	var img := Image.create(n, n, false, Image.FORMAT_RGB8)
	img.fill(base)
	_noise(img, rng, 0.08, 4000, 1)
	for t in 4:
		for i in n:
			for w in 3:
				img.set_pixel(clampi(t * 64 + w, 0, n - 1), i, base.darkened(0.3))
				img.set_pixel(i, clampi(t * 64 + w, 0, n - 1), base.darkened(0.3))
	for k in 3:
		var tx := rng.randi_range(0, 3) * 64 + 3
		var ty := rng.randi_range(0, 3) * 64 + 3
		for x in range(tx, tx + 61):
			for y in range(ty, ty + 61):
				img.set_pixel(x, y, img.get_pixel(x, y).darkened(0.15))
	return _tex(img)
