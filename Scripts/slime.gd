extends Area2D

var move = false
var direction = -1
var speed = 1

func _ready():
	if name == "Slime11":
		$AnimatedSprite2D.play("green")
		$AnimatedSprite2D.flip_h = true
	elif name == "Slime12":
		$AnimatedSprite2D.play("green")
		move = true
	elif name == "Slime13":
		$AnimatedSprite2D.play("green")
		move = true
	elif name == "Slime14":
		$AnimatedSprite2D.play("green")
		move = true
	elif name == "Slime15":
		$AnimatedSprite2D.play("green")
		move = true
	elif name == "Slime16":
		$AnimatedSprite2D.play("green")
		move = true
	elif name == "Slime17":
		$AnimatedSprite2D.play("green")
		move = true

func _on_body_entered(body: Node2D) -> void:
	if body.name.contains("Player"):
		if body.position.y - position.y < -2:
			body.velocity.y = -300
			$"../Jump".play()
			queue_free()
		else:
			if body.position.x > position.x:
				body.hit("from_left")
			else:
				body.hit("from_right")

func _physics_process(_delta: float) -> void:
	if move:
		position.x += speed * direction
		if not $Rays/DownLeft.is_colliding() or $Rays/Left.is_colliding():
			direction = 1
			$AnimatedSprite2D.flip_h = false
			
		elif not $Rays/DownRight.is_colliding() or $Rays/Right.is_colliding():
			direction = -1
			$AnimatedSprite2D.flip_h = true
