extends Node2D

var spawn = false

func _ready():
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
	Global.save_data.checkpoint = 0
	Global.save()
	Global.switch_scene("res://Scenes/title_screen.tscn")
	
func free_player():
	$"../Player".queue_free()
