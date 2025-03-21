extends Control


var is_remapping = false 
var action_to_remap = null 

func _ready():
	hide_unknown_controls()
		
func _input(event):
	if is_remapping and event is InputEventKey:
		InputMap.action_erase_events(action_to_remap)
		InputMap.action_add_event(action_to_remap, event)
		_update_button(action_to_remap, event)
		is_remapping = false
		action_to_remap = null
		
		accept_event()
		
func _update_button(a_t_r, key):
	var tex = key.as_text().trim_suffix( "(Physical)")
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
	match a_t_r:
		"left":
			$"HTP Menu 1/Left Button".text = tex
			Global.save_data.controls[0] = input_event_to_dict(key)
		"right":
			$"HTP Menu 1/Right Button".text = tex
			Global.save_data.controls[1] = input_event_to_dict(key)
		"jump":
			$"HTP Menu 1/Jump Button".text = tex
			Global.save_data.controls[2] = input_event_to_dict(key)
		"punch":
			$"HTP Menu 2/Punch Button".text = tex
			Global.save_data.controls[3] = input_event_to_dict(key)
			
func input_event_to_dict(event: InputEventKey) -> Dictionary:
	return {
		"keycode": event.keycode,
		"physical": false,
		"location": event.location,
		"pressed": event.pressed,
		"echo": event.echo
	}

func _on_left_button_pressed() -> void:
	$"../Click".play()
	if !is_remapping:
		is_remapping = true 
		action_to_remap = "left"
		$"HTP Menu 1/Left Button".text = ""

func _on_right_button_pressed() -> void:
	$"../Click".play()
	if !is_remapping:
		is_remapping = true 
		action_to_remap = "right"
		$"HTP Menu 1/Right Button".text = ""

func _on_jump_button_pressed() -> void:
	$"../Click".play()
	if !is_remapping:
		is_remapping = true 
		action_to_remap = "jump"
		$"HTP Menu 1/Jump Button".text = ""

func _on_punch_button_pressed() -> void:
	$"../Click".play()
	if !is_remapping:
		is_remapping = true 
		action_to_remap = "punch"
		$"HTP Menu 2/Punch Button".text = ""

func hide_unknown_controls():
	if Global.save_data.progress <= 3:
		pass
	if Global.save_data.progress <= 2:
		$"HTP Menu 2/Punch Label".text = "?????"
		$"HTP Menu 2/Punch".modulate = Color(0,0,0)
		$"HTP Menu 2/Punch Button".text = "?"
		$"HTP Menu 2/Punch Button".disabled = true
	if Global.save_data.progress <= 1:
		$"HTP Menu 2/Defeat Label".text = "???"
		$"HTP Menu 2/Fall".modulate = Color(0,0,0)
		$"HTP Menu 2/Enemy".modulate = Color(0,0,0) 
	if Global.save_data.progress <= 0:
		$"HTP Menu 1/Move Label".text = "????"
		$"HTP Menu 1/Jump Label".text = "????"
		$"HTP Menu 1/Move".modulate = Color(0,0,0)
		$"HTP Menu 1/Jump".modulate = Color(0,0,0)
		$"HTP Menu 1/Left Button".text = "?"
		$"HTP Menu 1/Left Button".disabled = true
		$"HTP Menu 1/Right Button".text = "?"
		$"HTP Menu 1/Right Button".disabled = true
		$"HTP Menu 1/Jump Button".text = "?"
		$"HTP Menu 1/Jump Button".disabled = true
