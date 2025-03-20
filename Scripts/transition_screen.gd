extends CanvasLayer

@onready var AP = $AnimationPlayer
	
func _ready():
	visible = true
	
func play(anim_name):
	AP.play(anim_name)
