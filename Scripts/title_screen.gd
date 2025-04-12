extends Control

var character
var page = 1

func _ready():
	LevelMusic.stop()
	character = Global.save_data.player
	set_controls()
	play_character_animations()
	call_deferred("set_collectables")
	$"Transition Screen".play("fade_in")

func _on_start_button_pressed() -> void:
	$Click.play()
	$"Transition Screen".play("fade_to_black")
	await get_tree().create_timer(1).timeout
	if Global.save_data.checkpoint < 6:
		Global.switch_scene("res://Scenes/level_1.tscn")
	elif Global.save_data.checkpoint < 10:
		Global.switch_scene("res://Scenes/level_2.tscn")
	else:
		Global.switch_scene("res://Scenes/level_3.tscn")
	
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
	Global.save_data.volume = \
	[AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master")),
	AudioServer.get_bus_volume_db(AudioServer.get_bus_index("music")),
	AudioServer.get_bus_volume_db(AudioServer.get_bus_index("sfx"))]
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
	play_character_animations()

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
	play_character_animations()

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
	play_character_animations()

func set_collectables():
	$"Collectable Menu/C/Collectable1".get_child(0).play("green")
	$"Collectable Menu/C/Collectable2".get_child(0).play("green")
	$"Collectable Menu/C/Collectable3".get_child(0).play("green")
	$"Collectable Menu/C/Collectable4".get_child(0).play("yellow")
	$"Collectable Menu/C/Collectable5".get_child(0).play("yellow")
	$"Collectable Menu/C/Collectable6".get_child(0).play("yellow")
	$"Collectable Menu/C/Collectable7".get_child(0).play("red")
	$"Collectable Menu/C/Collectable8".get_child(0).play("red")
	$"Collectable Menu/C/Collectable9".get_child(0).play("red")
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
			
func play_character_animations():
	$"Character Menu/Character".play(character)
	$"Howto Menu/HTP Menu 1/Move".play("Run"+character)
	$"Howto Menu/HTP Menu 1/Jump".play("Jump"+character)
	$"Howto Menu/HTP Menu 2/Punch".play("Punch"+character)
	$"Howto Menu/HTP Menu 2/Fall".play("Fall"+character)
	$"Howto Menu/HTP Menu 3/AirDash".play("Fall"+character)
	$"Howto Menu/HTP Menu 3/WallJump".play("Jump"+character)

func set_controls():
	if Global.save_data.controls[0] != null:
		InputMap.action_erase_events("left")
		var gsdcl = dict_to_input_event(Global.save_data.controls[0])
		InputMap.action_add_event("left", gsdcl)
		$"Howto Menu/HTP Menu 1/Left Button".text = trim_control(gsdcl)
	if Global.save_data.controls[1] != null:
		InputMap.action_erase_events("right")
		var gsdcl = dict_to_input_event(Global.save_data.controls[1])
		InputMap.action_add_event("right", gsdcl)
		$"Howto Menu/HTP Menu 1/Right Button".text = trim_control(gsdcl)
	if Global.save_data.controls[2] != null:
		InputMap.action_erase_events("jump")
		var gsdcl = dict_to_input_event(Global.save_data.controls[2])
		InputMap.action_add_event("jump", gsdcl)
		$"Howto Menu/HTP Menu 1/Jump Button".text = trim_control(gsdcl)
	if Global.save_data.controls[3] != null:
		InputMap.action_erase_events("punch")
		var gsdcl = dict_to_input_event(Global.save_data.controls[3])
		InputMap.action_add_event("punch", gsdcl)
		$"Howto Menu/HTP Menu 2/Punch Button".text = trim_control(gsdcl)
	if Global.save_data.controls[4] != null:
		InputMap.action_erase_events("dash")
		var gsdcl = dict_to_input_event(Global.save_data.controls[4])
		InputMap.action_add_event("dash", gsdcl)
		$"Howto Menu/HTP Menu 3/AirDash Button".text = trim_control(gsdcl)

func trim_control(long):
	var tex = long.as_text().trim_suffix( "(Physical)")
	if tex == "Right":
		tex = ">"
	elif tex == "Left":
		tex = "<"
	elif tex == "Up":
		tex = "^"
	elif tex == "Down":
		tex = "V"
	elif tex.length() > 3:
		tex = tex.left(3)
	return tex
	
func dict_to_input_event(data: Dictionary) -> InputEventKey:
	var event = InputEventKey.new()
	event.keycode = data.get("keycode", 0)
	event.location = data.get("location")
	event.pressed = data.get("pressed", false)
	event.echo = data.get("echo")
	return event

func _on_page_left_button_pressed() -> void:
	$Click.play()
	change_page(false)
	page -= 1
	if page == 0:
		page = 3 #change this
	change_page(true)

func _on_page_right_button_pressed() -> void:
	$Click.play()
	change_page(false)
	page += 1
	if page == 4:#change this
		page = 1
	change_page(true)

func change_page(make_visible):
	match page:
		1:
			$"Howto Menu/HTP Menu 1".visible = make_visible
		2:
			$"Howto Menu/HTP Menu 2".visible = make_visible
		3:
			$"Howto Menu/HTP Menu 3".visible = make_visible
		#add more here
	if make_visible:
		$"Howto Menu/Page Label".text = "Page: " + str(page)
