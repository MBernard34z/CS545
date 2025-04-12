extends Area2D

var level = 0
var CNum = 0

func _ready() -> void:
	if $"../..".name.contains("1"):
		level = 1
	elif $"../..".name.contains("2"):
		level = 2
	elif $"../..".name.contains("3"):
		level = 3
	else:
		return
		
	if name.contains("1"):
		CNum = 1
	elif name.contains("2"):
		CNum = 2
	elif name.contains("3"):
		CNum = 3
	
	match level:
		1:
			$AnimatedSprite2D.play("green")
		2:
			$AnimatedSprite2D.play("yellow")
		3:
			$AnimatedSprite2D.play("red")
			
	if Global.save_data.collectables[level-1][CNum-1] == 1:
		modulate.a8 = 60
	
	if level == 1 and CNum == 3:
		visible = false

func _on_body_entered(_body: Node2D) -> void:
	$"../Collect".play()
	Global.save_data.collectables[level-1][CNum-1] = 1
	Global.save()
	queue_free()
