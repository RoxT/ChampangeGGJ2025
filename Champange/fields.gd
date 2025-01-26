extends TileMapLayer

const PLANTED := 0
const EMPTY := 2
const HOUSE := 4

var tile_focus := Vector2i.ZERO
signal field_clicked(coord, type)
signal field_focus(coord, type)

# Called when the node enters the scene tree for the first time.
func _ready():
	CP.season_ended.connect(_on_season_ended)
	
func atlas(state:int)->Vector2i:
	return Vector2i(CP.season, state)

func _on_season_ended():
	for cell in get_used_cells():
		var y = get_cell_atlas_coords(cell).y
		set_cell(cell, 0, atlas(y))
	var capacity = get_used_cells_by_id(0, atlas(HOUSE)).size() * 3
	if CP.monk_box.get_child_count() < capacity and CP.season == CP.Seasons.SPRING:
		CP.monk_box.return_monk_to_box()
	

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
	var data = get_cell_tile_data(coord)
	if data:
		var type = data.get_custom_data("type")
		match type:
			"empty":
				set_cell(coord, 0, atlas(PLANTED))
				CP.add_plant(coord)
			"planted":
				CP.plants[coord] += 2
