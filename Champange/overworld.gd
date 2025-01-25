extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Fields.field_clicked.connect(_on_field_clicked)
	$Fields.field_focus.connect(_on_field_focus)
	CP.refresh.connect(_on_refresh)
	CP.season_ended.connect(_on_season_ended)

func _on_field_focus(coord, type):
	assert(coord is Vector2i)
	assert(type is String)

func _on_field_clicked(coord, type):
	assert(coord is Vector2i)
	assert(type is String)
	if $FieldMonkLayer.remove_monk_at(coord):
		$HUD/RightP/MonkBox.return_monk_to_box()
	elif $HUD/RightP/MonkBox.get_monk():
		$FieldMonkLayer.place_monk_at(coord)
	$HUD/RightP/Info._on_field_clicked(coord, type)

func _on_refresh():
	$HUD/LeftP/Stats._on_refresh()
	
func _on_season_ended():
	var working_monks = $FieldMonkLayer.get_used_cells()
	for monk_coord in working_monks:
		$Fields.do_work_at(monk_coord)
		$HUD/RightP/MonkBox.return_monk_to_box()
	$FieldMonkLayer.clear()

func _unhandled_input(event):
	if event.is_action_pressed("esc"):
		get_tree().quit()
