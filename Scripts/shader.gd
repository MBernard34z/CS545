extends CanvasLayer

@onready var shade = $ShaderRect

var num = 0

func _ready() -> void:
	$ShaderRect.material.shader = \
	load("res://Addons/accesibilitytools/shaders/normal_shader.gdshader")
	
func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("shader"):
		num += 1
		if num == 4:
			num = 0
		match num:
			0:
				$ShaderRect.material.shader = load(\
				"res://Addons/accesibilitytools/shaders/normal_shader.gdshader")
			1:
				$ShaderRect.material.shader = load(\
				"res://Addons/accesibilitytools/shaders/deuteranopia_shader.gdshader")
			2:
				$ShaderRect.material.shader = load(\
				"res://Addons/accesibilitytools/shaders/protanopia_shader.gdshader")
			3:
				$ShaderRect.material.shader = load(\
				"res://Addons/accesibilitytools/shaders/tritanopia_shader.gdshader")
