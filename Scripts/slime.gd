extends Area2D

var move = false
var direction = -1
var speed = 1

func _ready():
	match Global.save_data.difficulty:
		"E":
			speed = 0.7
		"M":
			speed = 1
		"H":
			speed = 1.4
	match name:
		"Slime11":
			$AnimatedSprite2D.play("green")
			$AnimatedSprite2D.flip_h = true
		"Slime12", "Slime13", "Slime14", "Slime15", "Slime16", "Slime17":
			$AnimatedSprite2D.play("green")
			move = true
		"Slime21":
			$AnimatedSprite2D.play("blue")
			$AnimatedSprite2D.flip_h = true
		"Slime22", "Slime23", "Slime24", "Slime25", "Slime26":
			$AnimatedSprite2D.play("blue")
			move = true
		"Slime31", "Slime32", "Slime33", "Slime34", "Slime35", "Slime36", "Slime37":
			$AnimatedSprite2D.play("red")
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
