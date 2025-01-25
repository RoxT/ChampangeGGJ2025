extends TileMapLayer

signal clicked(coord, type)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _unhandled_input(event):
	if event.is_action_pressed("select"):
		var coords = local_to_map(get_local_mouse_position())
		var data := get_cell_tile_data(coords)
		var type := ""
		if data:
			type = data.get_custom_data("type")
		clicked.emit(coords, type)
