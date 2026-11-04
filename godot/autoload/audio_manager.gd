extends Node
## Sound buses and one-shot sounds. (Phase 1: footsteps and the flashlight click are made in code.)

var _player: AudioStreamPlayer


func _ready() -> void:
	_player = AudioStreamPlayer.new()
	add_child(_player)


## A short generated click/thump, so the game needs no sound files yet.
func blip(freq: float = 440.0, seconds: float = 0.06, volume_db: float = -12.0) -> void:
	var gen := AudioStreamGenerator.new()
	gen.mix_rate = 22050
	gen.buffer_length = seconds + 0.1
	_player.stream = gen
	_player.volume_db = volume_db
	_player.play()
	var pb := _player.get_stream_playback() as AudioStreamGeneratorPlayback
	if pb == null:
		return
	var n := int(gen.mix_rate * seconds)
	for i in n:
		var env := 1.0 - float(i) / n
		var v := sin(TAU * freq * i / gen.mix_rate) * env * env
		pb.push_frame(Vector2(v, v))
