extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var jumping = false
var punching = false
var character = Global.save_data.player
var anim_tree
var anim_state

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
	elif jumping == true:
		jumping = false
		anim_state.travel("Land")

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor() and not punching:
		velocity.y = JUMP_VELOCITY
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
		
	if Input.is_action_just_pressed("punch") and is_on_floor() and not punching:
		anim_state.travel("Punch")
		punching = true
		await get_tree().create_timer(1).timeout
		punching = false
		
	anim_tree.set("parameters/Move/blend_position", direction)
		
	move_and_slide()
	
func _input(event: InputEvent) -> void:
	if event.is_action_released("escape"):
		Global.switch_scene("res://Scenes/title_screen.tscn")
