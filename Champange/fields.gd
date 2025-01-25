extends TileMapLayer

const FIELD := Vector2i(0, 0)
const TILLED := Vector2i(1, 0)

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
		
		if type == "field":
			do_work_on(coords, TILLED)

		elif type == "":
			do_work_on(coords, FIELD)
		
		data = get_cell_tile_data(coords)
		if data:
			type = data.get_custom_data("type")
		
		CP.refresh.emit()
		CP.field_clicked.emit(coords, type)

func do_work_on(coords:Vector2, new_tile:Vector2i):
	if CP.actions > 0:
		set_cell(coords, 0, new_tile)
		CP.actions -= 1
