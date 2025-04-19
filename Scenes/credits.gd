extends Node2D

var character = Global.save_data.player
var anim_tree
var anim_state

func _ready() -> void:
	$Player/AnimationTreeF1.active = false
	match character:
		"F1":
			$Player/AnimationTreeF1.active = true
			anim_tree = $Player/AnimationTreeF1
			anim_state = $Player/AnimationTreeF1.get("parameters/playback")
		"F2":
			$Player/AnimationTreeF2.active = true
			anim_tree = $Player/AnimationTreeF2
			anim_state = $Player/AnimationTreeF2.get("parameters/playback")
		"F3":
			$Player/AnimationTreeF3.active = true
			anim_tree = $Player/AnimationTreeF3
			anim_state = $Player/AnimationTreeF3.get("parameters/playback")
		"M1":
			$Player/AnimationTreeM1.active = true
			anim_tree = $Player/AnimationTreeM1
			anim_state = $Player/AnimationTreeM1.get("parameters/playback")
		"M2":
			$Player/AnimationTreeM2.active = true
			anim_tree = $Player/AnimationTreeM2
			anim_state = $Player/AnimationTreeM2.get("parameters/playback")
		"M3":
			$Player/AnimationTreeM3.active = true
			anim_tree = $Player/AnimationTreeM3
			anim_state = $Player/AnimationTreeM3.get("parameters/playback")
	anim_state.travel("Death")
	await get_tree().create_timer(1.5).timeout 
	$"Transition Screen".play("fade_in")
	if LevelMusic.volume_db != -18:
		LevelMusic.volume_db = -18
		LevelMusic.stream = load("res://Assets/Audio/Music/Retro Beat.ogg")
	if not LevelMusic.playing:
		LevelMusic.play()
	await get_tree().create_timer(8).timeout 
	$"Transition Screen".play("fade_to_black")
	await get_tree().create_timer(1.5).timeout 
	Global.switch_scene("res://Scenes/title_screen.tscn")
