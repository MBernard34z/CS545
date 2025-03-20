extends CanvasLayer

func _ready() -> void:
	$TextureRect.visible = false

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
