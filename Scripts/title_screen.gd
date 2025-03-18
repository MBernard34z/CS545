extends Control

var character

func _ready():
	$"Settings Menu".visible = false
	character = Global.save_data.player
	$"Character Menu/Character".play(character)

func _on_start_button_pressed() -> void:
	Global.switch_scene("res://Scenes/level_1.tscn")
	
func _on_settings_button_pressed() -> void:
	$"Settings Menu".visible = true
	
func _on_custom_char_button_pressed() -> void:
	$"Character Menu".visible = true
	
func _on_howtoplay_button_pressed() -> void:
	$"Howto Menu".visible = true

func _on_back_button_pressed() -> void:
	$"Settings Menu".visible = false
	$"Howto Menu".visible = false
	$"Character Menu".visible = false
	Global.save()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("escape"):
		_on_back_button_pressed()
		
func _on_male_female_button_pressed() -> void:
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
