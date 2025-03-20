extends Control

var character

func _ready():
	LevelMusic.stop()
	character = Global.save_data.player
	$"Character Menu/Character".play(character)
	call_deferred("set_collectables")
	$"Transition Screen".play("fade_in")

func _on_start_button_pressed() -> void:
	$Click.play()
	$"Transition Screen".play("fade_to_black")
	await get_tree().create_timer(1).timeout
	Global.switch_scene("res://Scenes/level_1.tscn")
	
func _on_settings_button_pressed() -> void:
	$Click.play()
	$"Settings Menu".visible = true
	
func _on_custom_char_button_pressed() -> void:
	$Click.play()
	$"Character Menu".visible = true
	
func _on_howtoplay_button_pressed() -> void:
	$Click.play()
	$"Howto Menu".visible = true
	
func _on_collectables_button_pressed() -> void:
	$Click.play()
	$"Collectable Menu".visible = true

func _on_back_button_pressed() -> void:
	$Click.play()
	$"Settings Menu".visible = false
	$"Howto Menu".visible = false
	$"Character Menu".visible = false
	$"Collectable Menu".visible = false
	Global.save()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("escape"):
		_on_back_button_pressed()
		
func _on_male_female_button_pressed() -> void:
	$Click.play()
	match character:
		"M1":
			character = "F1"
		"M2":
			character = "F2"
		"M3":
			character = "F3"
		"F1":
			character = "M1"
		"F2":
			character = "M2"
		"F3":
			character = "M3"
	Global.save_data.player = character 
	$"Character Menu/Character".play(character) 

func _on_left_button_pressed() -> void:
	$Click.play()
	match character:
		"M1":
			character = "M3"
		"M2":
			character = "M1"
		"M3":
			character = "M2"
		"F1":
			character = "F3"
		"F2":
			character = "F1"
		"F3":
			character = "F2"
	Global.save_data.player = character 
	$"Character Menu/Character".play(character) 

func _on_right_button_pressed() -> void:
	$Click.play()
	match character:
		"M1":
			character = "M2"
		"M2":
			character = "M3"
		"M3":
			character = "M1"
		"F1":
			character = "F2"
		"F2":
			character = "F3"
		"F3":
			character = "F1"
	Global.save_data.player = character 
	$"Character Menu/Character".play(character) 

func set_collectables():
	$"Collectable Menu/C/Collectable1".get_child(0).play("green")
	$"Collectable Menu/C/Collectable2".get_child(0).play("green")
	$"Collectable Menu/C/Collectable3".get_child(0).play("green")
	$"Collectable Menu/C/Collectable4".get_child(0).play("red")
	$"Collectable Menu/C/Collectable5".get_child(0).play("red")
	$"Collectable Menu/C/Collectable6".get_child(0).play("red")
	$"Collectable Menu/C/Collectable7".get_child(0).play("blue")
	$"Collectable Menu/C/Collectable8".get_child(0).play("blue")
	$"Collectable Menu/C/Collectable9".get_child(0).play("blue")
	if Global.save_data.collectables[0][0] == 1:
		$"Collectable Menu/C/Collectable1".modulate.a8 = 255
	if Global.save_data.collectables[0][1] == 1:
		$"Collectable Menu/C/Collectable2".modulate.a8 = 255
	if Global.save_data.collectables[0][2] == 1:
		$"Collectable Menu/C/Collectable3".modulate.a8 = 255
	if Global.save_data.collectables[1][0] == 1:
		$"Collectable Menu/C/Collectable4".modulate.a8 = 255
	if Global.save_data.collectables[1][1] == 1:
		$"Collectable Menu/C/Collectable5".modulate.a8 = 255
	if Global.save_data.collectables[1][2] == 1:
		$"Collectable Menu/C/Collectable6".modulate.a8 = 255
	if Global.save_data.collectables[2][0] == 1:
		$"Collectable Menu/C/Collectable7".modulate.a8 = 255
	if Global.save_data.collectables[2][1] == 1:
		$"Collectable Menu/C/Collectable8".modulate.a8 = 255
	if Global.save_data.collectables[2][2] == 1:
		$"Collectable Menu/C/Collectable9".modulate.a8 = 255
			
