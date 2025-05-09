extends Node

#global vars declared here
var current_scene = null
var file = "user://save09.save"

var save_data = {
	player = "M1",
	controls = [null, null, null, null, null],
	difficulty = "M",
	toggleDash = false,
	volume = [0,0,0],
	progress = 0,
	checkpoint = 0,
	collectables = [[0,0,0], [0,0,0], [0,0,0]],
	game_beat = false
}
#Controls
#Left
#Right
#Jump
#Punch

#Progress
#0: None
#1: Move and Jump
#2: Kill enemy
#3: Punch
#4: Dash
#5: Wall jump
#6: Lava walk
#7: Double Jump

#checkpoint
#Level 1: 0-5
#Level 2: 6-9
#Level 3: 10-

func _ready():
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count()-1)
	#save() #refresh game
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
	var save_game = FileAccess.open(file, FileAccess.WRITE)
	if save_game:
		save_game.store_var(save_data)
		save_game.close() 
		
func load_save():
	if not FileAccess.open(file, FileAccess.READ):
		save()
		return
	var save_game = FileAccess.open(file, FileAccess.READ)
	if save_game:
		save_data = save_game.get_var()
		save_game.close()
