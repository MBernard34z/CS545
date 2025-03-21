extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	match Global.save_data.difficulty:
		"E":
			$Difficulty.text = "Easy"
		"M":
			$Difficulty.text = "Medium"
		"H":
			$Difficulty.text = "Hard"


func _on_diff_left_button_pressed() -> void:
	$"../Click".play()
	match Global.save_data.difficulty:
		"E":
			pass
		"M":
			Global.save_data.difficulty = "E"
			$Difficulty.text = "Easy"
		"H":
			Global.save_data.difficulty = "M"
			$Difficulty.text = "Medium"

func _on_diff_right_button_pressed() -> void:
	$"../Click".play()
	match Global.save_data.difficulty:
		"E":
			Global.save_data.difficulty = "M"
			$Difficulty.text = "Medium"
		"M":
			Global.save_data.difficulty = "H"
			$Difficulty.text = "Hard"
		"H":
			pass

func _on_change_controls_button_pressed() -> void:
	$"../Click".play()
	$"../Howto Menu".visible = true
	$".".visible = false
