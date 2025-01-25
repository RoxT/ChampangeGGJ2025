extends TileMapLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func remove_monk_at(coord)->bool:
	if get_cell_source_id(coord) < 0:
		return false
	else:
		erase_cell(coord)
		return true

func place_monk_at(coord):
	set_cell(coord, 0, Vector2i.ZERO)
