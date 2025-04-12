extends CanvasLayer

var left
var right
var jump
var punch
var dash

func _ready() -> void:
	$TextureRect.visible = false
	update_buttons()

func update_buttons():
	if Global.save_data.controls[0] == null:
		left = "A"
	else:
		left = trim_button(OS.get_keycode_string\
		(Global.save_data.controls[0].keycode))
	if Global.save_data.controls[1] == null:
		right = "D"
	else:
		right = trim_button(OS.get_keycode_string\
		(Global.save_data.controls[1].keycode))
	if Global.save_data.controls[2] == null:
		jump = "W"
	else:
		jump = trim_button(OS.get_keycode_string\
		(Global.save_data.controls[2].keycode))
	if Global.save_data.controls[3] == null:
		punch = "P"
	else:
		punch = trim_button(OS.get_keycode_string\
		(Global.save_data.controls[3].keycode))
	if Global.save_data.controls[4] == null:
		dash = "L"
	else:
		dash = trim_button(OS.get_keycode_string\
		(Global.save_data.controls[4].keycode))
	$Movement/Label.text = "Move with\n["+left+"] and ["+right+"]"
	$Jump/Label2.text = "Jump with ["+jump+"]"
	$Punch/Label6.text = "Punch rubble\nwith ["+punch+"]"
	$Dash/Label8.text = "Air Dash with ["+dash+"]"
	$Wall/Label9.text = "Wall jump by repeatedly\npressing ["+jump+"]"
	
func trim_button(long):
	var tex = long
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

func _on_sp_11_body_entered(_body: Node2D) -> void:
	$TextureRect.visible = true
	$Movement.visible = true
	if Global.save_data.progress < 1:
		Global.save_data.progress = 1
		Global.save()

func _on_sp_11_body_exited(_body: Node2D) -> void:
	$TextureRect.visible = false
	$Movement.visible = false

func _on_sp_12_body_entered(_body: Node2D) -> void:
	$TextureRect.visible = true
	$Jump.visible = true

func _on_sp_12_body_exited(_body: Node2D) -> void:
	$TextureRect.visible = false
	$Jump.visible = false

func _on_sp_13_body_entered(_body: Node2D) -> void:
	$TextureRect.visible = true
	$Checkpoint.visible = true

func _on_sp_13_body_exited(_body: Node2D) -> void:
	$TextureRect.visible = false
	$Checkpoint.visible = false

func _on_sp_14_body_entered(_body: Node2D) -> void:
	$TextureRect.visible = true
	$Enemy.visible = true
	if Global.save_data.progress < 2:
		Global.save_data.progress = 2
		Global.save()

func _on_sp_14_body_exited(_body: Node2D) -> void:
	$TextureRect.visible = false
	$Enemy.visible = false
	
func bacon():
	$TextureRect.visible = true
	$Bacon.visible = true
	$BaconTimer.start()

func _on_bacon_timer_timeout() -> void:
	$TextureRect.visible = false
	$Bacon.visible = false

func _on_sp_15_body_entered(_body: Node2D) -> void:
	$BaconTimer.stop()
	$Bacon.visible = false
	$TextureRect.visible = true
	$Punch.visible = true

func _on_sp_15_body_exited(_body: Node2D) -> void:
	$TextureRect.visible = false
	$Punch.visible = false

func _on_sp_16_body_entered(_body: Node2D) -> void:
	$TextureRect.visible = true
	$Tree.visible = true

func _on_sp_16_body_exited(_body: Node2D) -> void:
	$TextureRect.visible = false
	$Tree.visible = false


func _on_sp_21_body_entered(_body: Node2D) -> void:
	$TextureRect.visible = true
	$Dash.visible = true

func _on_sp_21_body_exited(_body: Node2D) -> void:
	$TextureRect.visible = false
	$Dash.visible = false

func _on_sp_22_body_entered(_body: Node2D) -> void:
	$TextureRect.visible = true
	$Wall.visible = true

func _on_sp_22_body_exited(_body: Node2D) -> void:
	$TextureRect.visible = false
	$Wall.visible = false
