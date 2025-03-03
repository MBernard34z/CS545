extends Control

func _ready():
	$"Settings Menu".visible = false

func _on_start_button_pressed() -> void:
	Global.switch_scene("res://Scenes/level_1.tscn")
	
func _on_settings_button_pressed() -> void:
	$"Settings Menu".visible = true

func _on_back_button_pressed() -> void:
	$"Settings Menu".visible = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("escape"):
		$"Settings Menu".visible = false
