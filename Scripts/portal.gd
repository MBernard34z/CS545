extends Node2D

var spawn = false

func _ready():
	if name == "PortalGreenS":
		$AnimatedSprite2D.play("green")
		$AnimatedSprite2D.flip_h = false
		await get_tree().create_timer(1.5).timeout
		$AnimatedSprite2D.play("greenClose")
	else:
		$AnimatedSprite2D.play("greenClose")

func _on_p_1_body_entered(_body: Node2D) -> void:
	if not spawn:
		$AnimatedSprite2D.flip_h = true
		spawn = true
		$AnimatedSprite2D.play("greenOpen")
		await get_tree().create_timer(1).timeout
		$AnimatedSprite2D.play("green")

func _on_p_2_body_entered(_body: Node2D) -> void:
	$"../Player/Camera2D".position_smoothing_enabled = false
	$"../Player/Camera2D".reparent($"..")
	call_deferred("free_player")
	await get_tree().create_timer(1.5).timeout
	$AnimatedSprite2D.play("greenClose")
	await get_tree().create_timer(2).timeout
	$"../Transition Screen".play("fade_to_black")
	await get_tree().create_timer(1).timeout
	Global.save_data.checkpoint = 6
	Global.save()
	Global.switch_scene("res://Scenes/level_2.tscn")
	
func free_player():
	$"../Player".queue_free()


func _on_p_3_body_entered(_body: Node2D) -> void:
	if not spawn:
		$AnimatedSprite2D.flip_h = true
		spawn = true
		$AnimatedSprite2D.play("purpleOpen")
		await get_tree().create_timer(1).timeout
		$AnimatedSprite2D.play("purple")

func _on_p_4_body_entered(_body: Node2D) -> void:
	$"../Player/Camera2D".position_smoothing_enabled = false
	#$"../Player/Camera2D".reparent($"..")
	#call_deferred("free_player")
	$"../Player".set_physics_process(false)
	$"../Player".visible = false
	await get_tree().create_timer(1.5).timeout
	$AnimatedSprite2D.play("purpleClose")
	await get_tree().create_timer(2).timeout
	$"../Transition Screen".play("fade_to_black")
	await get_tree().create_timer(1).timeout
	#Global.save_data.checkpoint = 0 #change this!
	Global.save()
	Global.switch_scene("res://Scenes/title_screen.tscn") #change this!
