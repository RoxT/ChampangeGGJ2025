extends TileMapLayer

const FIELD := Vector2i(1, 1)
const TILLED := Vector2i(2, 1)

var tile_focus := Vector2i.ZERO
signal field_clicked(coord, type)
signal field_focus(coord, type)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _unhandled_input(event):
	var coords = local_to_map(get_local_mouse_position())
	var type := ""
	if coords != tile_focus:
		var data := get_cell_tile_data(coords)
		if data:
			type = data.get_custom_data("type")
		
		
		CP.refresh.emit()
		field_focus.emit(coords, type)
	if event.is_action_pressed("select"):
		var data := get_cell_tile_data(coords)
		if data:
			type = data.get_custom_data("type")
		field_clicked.emit(coords, type)
		
		
	

func do_work_on(coords:Vector2, new_tile:Vector2i):
	if CP.actions > 0:
		set_cell(coords, 0, new_tile)
		CP.actions -= 1
