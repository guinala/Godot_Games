extends Node
const CLICK_1 = preload("res://LeapNight Assets/Sound/click1.ogg")
const IMPACT_BELL_HEAVY_004 = preload("res://LeapNight Assets/Sound/impactBell_heavy_004.ogg")
const JUMPING_SFX = preload("res://LeapNight Assets/Sound/jumping sfx.mp3")


@onready var sfx_streams: Node = $SFXStreams

func play_fruit() -> void:
	play_audio(CLICK_1)

func play_jump() -> void:
	play_audio(JUMPING_SFX)

func play_impact() -> void:
	play_audio(IMPACT_BELL_HEAVY_004)
	
func play_audio(audio: AudioStream) -> void:
	var audio_stream := get_free_stream() 
	audio_stream.stream = audio
	audio_stream.play()

func get_free_stream() -> AudioStreamPlayer:
	for stream: AudioStreamPlayer in sfx_streams.get_children():
		if not stream.playing:
			return stream
	return null
