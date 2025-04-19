extends Node2D

var rocks = [false, false]

func _ready() -> void:
	$Player/Camera2D.drag_horizontal_enabled = false
	$Player/Camera2D.drag_vertical_enabled = false
	match Global.save_data.checkpoint:
		6:
			$Player.position = Vector2(266, 512)
		7:
			$Player.position = Vector2(1734, 512)
		8:
			$Player.position = Vector2(2848, 480)
		9:
			$Player.position = Vector2(4621, 448)
	await get_tree().create_timer(0.5).timeout 
	$Player/Camera2D.drag_horizontal_enabled = true
	$Player/Camera2D.drag_vertical_enabled = true
	$"Transition Screen".play("fade_in")
	if LevelMusic.volume_db != -18:
		LevelMusic.volume_db = -18
		LevelMusic.stream = load("res://Assets/Audio/Music/Retro Beat.ogg")
	if not LevelMusic.playing:
		LevelMusic.play()


func _on_deathpit_body_entered(_body: Node2D) -> void:
	$"Transition Screen".play("fade_to_black")
	await get_tree().create_timer(1).timeout
	Global.switch_scene("res://Scenes/level_2.tscn")


func _on_ch_pt_7_body_entered(_body: Node2D) -> void:
	if Global.save_data.checkpoint < 7:
		Global.save_data.checkpoint = 7
		Global.save()

func _on_ch_pt_8_body_entered(_body: Node2D) -> void:
	if Global.save_data.checkpoint < 8:
		Global.save_data.checkpoint = 8
		Global.save()

func _on_ch_pt_9_body_entered(_body: Node2D) -> void:
	if Global.save_data.checkpoint < 9:
		Global.save_data.checkpoint = 9
		Global.save()

func _on_r_1_area_entered(_area: Area2D) -> void:
	if not rocks[0]:
		rocks[0] = true
		$Rocks/Smash.play()
		$TileMap/Boxes1.erase_cell(Vector2i(10, 1))

func _on_r_2_area_entered(_area: Area2D) -> void:
	if not rocks[1]:
		rocks[1] = true
		$Rocks/Smash.play()
		$TileMap/Boxes2.erase_cell(Vector2i(33, 0))

func _on_pizza_body_entered(_body: Node2D) -> void:
	Global.save_data.progress = 4
	$Collectables/Eat.play()
	$Pizza.queue_free()

func _on_taco_body_entered(_body: Node2D) -> void:
	Global.save_data.progress = 5
	$Collectables/Eat.play()
	$Taco.queue_free()
