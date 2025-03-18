extends Node

#global vars declared here
var current_scene = null

var save_data = {
	player = "M1",
	controls = [],
	difficulty = "M",
	colorblind = false,
	volume = 5,
	progress = 0
}

func _ready():
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count()-1)
	load_save()

func switch_scene(res_path):
	call_deferred("_deferred_switch_scene",res_path)
	
func _deferred_switch_scene(res_path):
	current_scene.free()
	var s = load(res_path)
	current_scene = s.instantiate()
	get_tree().root.add_child(current_scene)
	get_tree().current_scene = current_scene

func save():
	var save_game = FileAccess.open("user://save.save", FileAccess.WRITE)
	if save_game:
		save_game.store_var(save_data)
		save_game.close() 
		
func load_save():
	if not FileAccess.open("user://save.save", FileAccess.READ):
		save()
		return
	var save_game = FileAccess.open("user://save.save", FileAccess.READ)
	if save_game:
		save_data = save_game.get_var()
		save_game.close()
