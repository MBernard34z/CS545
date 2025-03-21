extends HSlider


@export var bus_name: String 

var bus_index: int 

func _ready():
	bus_index = AudioServer.get_bus_index(bus_name)
	value_changed.connect(_on_value_changed)
	
	AudioServer.set_bus_volume_db(bus_index, Global.save_data.volume[bus_index])
	
	value = db_to_linear(AudioServer.get_bus_volume_db(bus_index))/2

func _on_value_changed(valUe: float) -> void:
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(valUe*2))
	
func play_click(_x = "x") -> void:
	$Click.play()
