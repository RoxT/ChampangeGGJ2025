extends TileMapLayer

const EMPTY := Vector2i(0, 1)
const FIELD := Vector2i(1, 1)
const TILLED := Vector2i(2, 1)
const WINTER := Vector2i(3, 1)

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
		

func do_work_at(coord:Vector2i):
	var atlas = get_cell_atlas_coords(coord)
	match atlas:
		EMPTY:
			set_cell(coord, 0, FIELD)
		FIELD:
			set_cell(coord, 0, TILLED)
		TILLED:
			set_cell(coord, 0, WINTER)
