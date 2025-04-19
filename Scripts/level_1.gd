extends Node2D

var rocks = [false, false, false]

func _ready() -> void:
	$Player/Camera2D.drag_horizontal_enabled = false
	$Player/Camera2D.drag_vertical_enabled = false
	match Global.save_data.checkpoint:
		0:
			$Player.position = Vector2(181, 512)
		1:
			$Player.position = Vector2(1586, 416)
		2:
			$Player.position = Vector2(2650, 384)
		3:
			$Player.position = Vector2(3666, 128)
		4:
			$Player.position = Vector2(4978, 160)
		5:
			$Player.position = Vector2(6675, 640)
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
	Global.switch_scene("res://Scenes/level_1.tscn")


func _on_ch_pt_1_body_entered(_body: Node2D) -> void:
	if Global.save_data.checkpoint < 1:
		Global.save_data.checkpoint = 1
		Global.save()

func _on_ch_pt_2_body_entered(_body: Node2D) -> void:
	if Global.save_data.checkpoint < 2:
		Global.save_data.checkpoint = 2
		Global.save()

func _on_ch_pt_3_body_entered(_body: Node2D) -> void:
	if Global.save_data.checkpoint < 3:
		Global.save_data.checkpoint = 3
		Global.save()

func _on_ch_pt_4_body_entered(_body: Node2D) -> void:
	if Global.save_data.checkpoint < 4:
		Global.save_data.checkpoint = 4
		Global.save()

func _on_ch_pt_5_body_entered(_body: Node2D) -> void:
	if Global.save_data.checkpoint < 5:
		Global.save_data.checkpoint = 5
		Global.save()


func _on_bacon_body_entered(_body: Node2D) -> void:
	$Signpost.bacon()
	Global.save_data.progress = 3
	$Collectables/Eat.play()
	$Bacon.queue_free()

func _on_r_1_area_entered(_area: Area2D) -> void:
	if not rocks[0]:
		rocks[0] = true
		$Rocks/Smash.play()
		$TileMap/Main.erase_cell(Vector2i(218, 16))
		$TileMap/Main.erase_cell(Vector2i(218, 17))
		$TileMap/Main.erase_cell(Vector2i(218, 18))
		$TileMap/Main.erase_cell(Vector2i(218, 19))
		
		$TileMap/Main.erase_cell(Vector2i(219, 16))
		$TileMap/Main.erase_cell(Vector2i(219, 17))
		$TileMap/Main.erase_cell(Vector2i(219, 18))
		$TileMap/Main.erase_cell(Vector2i(219, 19))
		
		$TileMap/Main.erase_cell(Vector2i(220, 16))
		$TileMap/Main.erase_cell(Vector2i(220, 17))
		$TileMap/Main.erase_cell(Vector2i(220, 18))
		$TileMap/Main.erase_cell(Vector2i(220, 19))
		
		$TileMap/Main.erase_cell(Vector2i(221, 17))
		$TileMap/Main.erase_cell(Vector2i(221, 18))
		$TileMap/Main.erase_cell(Vector2i(221, 19))

func _on_r_2_area_entered(_area: Area2D) -> void:
	if not rocks[1]:
		rocks[1] = true
		$Rocks/Smash.play()
		$TileMap/Main.erase_cell(Vector2i(241, 12))
		$TileMap/Main.erase_cell(Vector2i(241, 13))
		$TileMap/Main.erase_cell(Vector2i(241, 14))
		$TileMap/Main.erase_cell(Vector2i(241, 15))
		
		$TileMap/Main.erase_cell(Vector2i(242, 11))
		$TileMap/Main.erase_cell(Vector2i(242, 12))
		$TileMap/Main.erase_cell(Vector2i(242, 13))
		$TileMap/Main.erase_cell(Vector2i(242, 14))
		$TileMap/Main.erase_cell(Vector2i(242, 15))
		
		$TileMap/Main.erase_cell(Vector2i(243, 11))
		$TileMap/Main.erase_cell(Vector2i(243, 12))
		$TileMap/Main.erase_cell(Vector2i(243, 13))
		$TileMap/Main.erase_cell(Vector2i(243, 14))
		$TileMap/Main.erase_cell(Vector2i(243, 15))
		
		$TileMap/Main.erase_cell(Vector2i(244, 11))
		$TileMap/Main.erase_cell(Vector2i(244, 12))
		$TileMap/Main.erase_cell(Vector2i(244, 13))
		$TileMap/Main.erase_cell(Vector2i(244, 14))
		$TileMap/Main.erase_cell(Vector2i(244, 15))
		
		$TileMap/Main.erase_cell(Vector2i(245, 12))
		$TileMap/Main.erase_cell(Vector2i(245, 13))
		$TileMap/Main.erase_cell(Vector2i(245, 14))
		$TileMap/Main.erase_cell(Vector2i(245, 15))
	
func _on_r_3_area_entered(_area: Area2D) -> void:
	if not rocks[2]:
		rocks[2] = true
		$Rocks/Smash.play()
		$TileMap/Main.erase_cell(Vector2i(202, 17))
		$TileMap/Main.erase_cell(Vector2i(202, 18))
		$TileMap/Main.erase_cell(Vector2i(202, 19))
		$TileMap/Main.erase_cell(Vector2i(203, 17))
		$TileMap/Main.erase_cell(Vector2i(203, 18))
		$TileMap/Main.erase_cell(Vector2i(203, 19))
		$TileMap/Main.erase_cell(Vector2i(204, 17))
		$TileMap/Main.erase_cell(Vector2i(204, 18))
		$TileMap/Main.erase_cell(Vector2i(204, 19))
		$Collectables/Collectable3.visible = true
