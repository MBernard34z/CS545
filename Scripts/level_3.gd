extends Node2D

var rocks = [false, false]

func _ready() -> void:
	$Player/Camera2D.drag_horizontal_enabled = false
	$Player/Camera2D.drag_vertical_enabled = false
	match Global.save_data.checkpoint:
		10:
			$Player.position = Vector2(288, 512)
		11:
			$Player.position = Vector2(1920, 96)
			Global.save_data.progress = 5
		12:
			$Player.position = Vector2(3342, -64)
		13:
			$Player.position = Vector2(4652, 512)
			Global.save_data.progress = 6
	await get_tree().create_timer(0.7).timeout 
	$Player/Camera2D.drag_horizontal_enabled = true
	$Player/Camera2D.drag_vertical_enabled = true
	$"Transition Screen".play("fade_in")
	if LevelMusic.volume_db != -1:
		LevelMusic.volume_db = -1
		LevelMusic.stream = load("res://Assets/Audio/Music/Retro Mystic.ogg")
	if not LevelMusic.playing:
		LevelMusic.play()


func _on_deathpit_body_entered(_body: Node2D) -> void:
	$"Transition Screen".play("fade_to_black")
	await get_tree().create_timer(1).timeout
	Global.switch_scene("res://Scenes/level_3.tscn")


func _on_ch_pt_11_body_entered(_body: Node2D) -> void:
	if Global.save_data.checkpoint < 11:
		Global.save_data.checkpoint = 11
		Global.save()

func _on_ch_pt_12_body_entered(_body: Node2D) -> void:
	if Global.save_data.checkpoint < 12:
		Global.save_data.checkpoint = 12
		Global.save()

func _on_ch_pt_13_body_entered(_body: Node2D) -> void:
	if Global.save_data.checkpoint < 13:
		Global.save_data.checkpoint = 13
		Global.save()


func _on_curry_body_entered(_body: Node2D) -> void:
	Global.save_data.progress = 6
	$Collectables/Eat.play()
	$Curry.queue_free()

func _on_turkey_body_entered(_body: Node2D) -> void:
	Global.save_data.progress = 7
	$Collectables/Eat.play()
	$Turkey.queue_free()


func _on_end_body_entered(_body: Node2D) -> void:
	await get_tree().create_timer(0.2).timeout
	$"Transition Screen".play("fade_to_black")
	await get_tree().create_timer(1).timeout
	Global.save_data.progress = 0
	Global.save_data.checkpoint = 0 
	Global.save_data.game_beat = true
	Global.save()
	Global.switch_scene("res://Scenes/credits.tscn")
