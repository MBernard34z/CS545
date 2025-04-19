extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -430.0
var acc = 1000
var jumping = false
var punching = false
var character = Global.save_data.player
var anim_tree
var anim_state
var health = 3
var game_paused = false
var iframes = false
@onready var ctimer = $CTimer
var onfloor = true
var dash_speed = 700.0
var air_resistance = 225.0
var can_air_dash = false
var toggleDashCharged = false
var can_double_jump = true

func _ready():
	match Global.save_data.difficulty:
		"E":
			health = 5
		"M":
			health = 3
		"H":
			health = 1
	$AnimationTreeF1.active = false
	match character:
		"F1":
			$AnimationTreeF1.active = true
			anim_tree = $AnimationTreeF1
			anim_state = $AnimationTreeF1.get("parameters/playback")
		"F2":
			$AnimationTreeF2.active = true
			anim_tree = $AnimationTreeF2
			anim_state = $AnimationTreeF2.get("parameters/playback")
		"F3":
			$AnimationTreeF3.active = true
			anim_tree = $AnimationTreeF3
			anim_state = $AnimationTreeF3.get("parameters/playback")
		"M1":
			$AnimationTreeM1.active = true
			anim_tree = $AnimationTreeM1
			anim_state = $AnimationTreeM1.get("parameters/playback")
		"M2":
			$AnimationTreeM2.active = true
			anim_tree = $AnimationTreeM2
			anim_state = $AnimationTreeM2.get("parameters/playback")
		"M3":
			$AnimationTreeM3.active = true
			anim_tree = $AnimationTreeM3
			anim_state = $AnimationTreeM3.get("parameters/playback")

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
		jumping = true
		anim_state.travel("Fall")
		onfloor = false
	elif jumping == true:
		jumping = false
		anim_state.travel("Land")
		onfloor = true
		can_air_dash = false
	else:
		can_double_jump = true
		onfloor = true
		can_air_dash = false

	var direction := Input.get_axis("left", "right")
	
	if Input.is_action_just_pressed("jump"):
		if (Global.save_data.progress >= 7 and not is_on_floor() \
		and can_double_jump and not $WallRays/LeftRay.is_colliding()\
		and not $WallRays/RightRay.is_colliding()):
			can_double_jump = false
			velocity.y = JUMP_VELOCITY
			$Jump.play()
		elif (is_on_floor() or not ctimer.is_stopped()) and not punching:
			velocity.y = JUMP_VELOCITY
			$Jump.play()
			anim_state.travel("Jump")
			can_air_dash = true
			if toggleDashCharged:
				toggle_dash()
		elif Global.save_data.progress >= 5:
			if $AnimatedSprite2D.flip_h and $WallRays/LeftRay.is_colliding():
				velocity.y = JUMP_VELOCITY * 0.85
				Input.action_release("left")
				$AnimatedSprite2D.flip_h = false
				velocity.x = 0.7 * dash_speed
				$Jump.play()
				anim_state.travel("Jump")
				can_air_dash = false
			elif not $AnimatedSprite2D.flip_h and $WallRays/RightRay.is_colliding():
				velocity.y = JUMP_VELOCITY * 0.9
				Input.action_release("right")
				$AnimatedSprite2D.flip_h = true
				velocity.x = -0.7 * dash_speed
				$Jump.play()
				anim_state.travel("Jump")
				can_air_dash = false

	if direction and not punching and (is_on_floor() or can_air_dash):
		velocity.x = direction * SPEED
	elif not is_on_floor() and not can_air_dash:
		velocity.x = move_toward(velocity.x, direction * SPEED, acc * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if direction > 0 and not punching:
		$AnimatedSprite2D.flip_h = false
	elif direction < 0 and not punching:
		$AnimatedSprite2D.flip_h = true
		
	if Input.is_action_just_pressed("punch") and is_on_floor() and not punching\
	and Global.save_data.progress >= 3:
		anim_state.travel("Punch")
		punching = true
		await get_tree().create_timer(0.2).timeout
		if $AnimatedSprite2D.flip_h:
			$Punch/CollisionShape2D.position.x = -31.5
		else:
			$Punch/CollisionShape2D.position.x = 31.5
		await get_tree().create_timer(0.8).timeout
		$Punch/CollisionShape2D.position.x = 0
		punching = false
		
	if Input.is_action_just_pressed("dash") and can_air_dash and not is_on_floor()\
	and Global.save_data.progress >= 4:
		can_air_dash = false
		if $AnimatedSprite2D.flip_h == false:
			velocity.x = dash_speed 
		else:
			velocity.x = -dash_speed 
		velocity.y = JUMP_VELOCITY * 0.4
	
	elif Input.is_action_just_pressed("dash") and Global.save_data.progress >= 4\
	and Global.save_data.toggleDash:
		toggleDashCharged = true
		
	anim_tree.set("parameters/Move/blend_position", direction)
		
	move_and_slide()
	
	if onfloor and !is_on_floor() and not velocity.y < 0:
		ctimer.start()
		can_air_dash = true
	
func _input(event: InputEvent) -> void:
	if event.is_action_released("escape"):
		Global.save()
		$"../Transition Screen".play("fade_to_black")
		await get_tree().create_timer(1).timeout
		Global.switch_scene("res://Scenes/title_screen.tscn")
		#game_paused = !game_paused
		#if game_paused:
			#Engine.time_scale = 0
			#set_physics_process(false)
			#get_tree().paused = true
			#pause menu.visible
		#else:
			#Engine.time_scale = 1
			#set_physics_process(true)
			#pausemenu.visible 
		
func hit(from):
	if not iframes:
		$Hurt.play()
		iframes = true
		health -= 1
		if health <= 0:
			set_physics_process(false)
			anim_state.travel("Damage")
			if from == "from_left":
				position.x += 25
			elif from == "from_right":
				position.x -= 25
			anim_state.travel("Death")
			await get_tree().create_timer(1.5).timeout
			$"../Transition Screen".play("fade_to_black")
			await get_tree().create_timer(1).timeout
			match $"..".name:
				"Level 1":
					Global.switch_scene("res://Scenes/level_1.tscn")
				"Level 2":
					Global.switch_scene("res://Scenes/level_2.tscn")
				"Level 3":
					Global.switch_scene("res://Scenes/level_3.tscn")
		else:
			set_physics_process(false)
			anim_state.travel("Damage")
			if from == "from_left":
				position.x += 25
			else:
				position.x -= 25
			await get_tree().create_timer(0.5).timeout
			set_physics_process(true)
			await get_tree().create_timer(0.25).timeout 
			iframes = false

func toggle_dash():
	if can_air_dash:
		can_air_dash = false
		toggleDashCharged = false
		await get_tree().create_timer(0.4).timeout
		if $AnimatedSprite2D.flip_h == false:
			velocity.x = dash_speed 
		else:
			velocity.x = -dash_speed 
		velocity.y = JUMP_VELOCITY * 0.4
		
func _on_lava_body_entered(_body: Node2D) -> void:
	if Global.save_data.progress < 6:
		health = 1
		hit("none")
