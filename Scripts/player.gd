extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -430.0
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

func _ready():
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
	else:
		onfloor = true

	if Input.is_action_just_pressed("jump") and \
	(is_on_floor() or not ctimer.is_stopped()) and not punching:
		velocity.y = JUMP_VELOCITY
		$Jump.play()
		anim_state.travel("Jump")

	var direction := Input.get_axis("left", "right")
	if direction and not punching:
		velocity.x = direction * SPEED
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
		
	anim_tree.set("parameters/Move/blend_position", direction)
		
	move_and_slide()
	
	if onfloor and !is_on_floor() and not velocity.y < 0:
		ctimer.start()
	
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
			else:
				position.x -= 25
			anim_state.travel("Death")
			await get_tree().create_timer(1.5).timeout
			$"../Transition Screen".play("fade_to_black")
			await get_tree().create_timer(1).timeout
			Global.switch_scene("res://Scenes/level_1.tscn")
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
