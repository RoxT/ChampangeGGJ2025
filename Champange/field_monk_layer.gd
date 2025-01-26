extends TileMapLayer

const Floaty := preload("res://floaty.tscn")

const PLANTING := "planting"
const PRUNING := "pruning"

const TENDING := "tending"
const HARVESTING := "harvesting"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func remove_monk_at(coord)->bool:
	if get_cell_source_id(coord) < 0:
		return false
	else:
		erase_cell(coord)
		return true

func place_monk_at(coord, type):
	set_cell(coord, 0, Vector2i.ZERO)
	var floaty = Floaty.instantiate()
	floaty.position = map_to_local(coord) + Vector2(-6, -32)
	match CP.season:
		CP.Seasons.SPRING:
			if type == "empty":
				floaty.text = PLANTING
			else:
				floaty.text = PRUNING
		CP.Seasons.SUMMER:
			floaty.text = TENDING
		CP.Seasons.FALL:
			floaty.text = HARVESTING
	add_child(floaty)
